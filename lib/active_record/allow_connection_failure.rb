raise("Cannot monkeypatch ActiveRecord if it isn't defined in your application.") unless defined?(ActiveRecord)

require "active_record/allow_connection_failure/version"

module ActiveRecord
  module AllowConnectionFailure
    # monkeypatches activerecord/lib/active_record/query_cache.rb
    ActiveRecord::QueryCache.class_eval do
      def self.run
        if ActiveRecord::Base.connected?
          connection    = ActiveRecord::Base.connection
          enabled       = connection.query_cache_enabled
          connection_id = ActiveRecord::Base.connection_id
          connection.enable_query_cache!

          [enabled, connection_id]
        end
      end

      def self.complete(state)
        if ActiveRecord::Base.connected?
          enabled, connection_id = state

          ActiveRecord::Base.connection_id = connection_id
          ActiveRecord::Base.connection.clear_query_cache
          ActiveRecord::Base.connection.disable_query_cache! unless enabled
        end
      end

      def self.install_executor_hooks(executor = ActiveSupport::Executor)
        executor.register_hook(self)

        executor.to_complete do
          unless ActiveRecord::Base.connected? && ActiveRecord::Base.connection.transaction_open?
            ActiveRecord::Base.clear_active_connections!
          end
        end
      end
    end

    # monkeypatches activerecord/lib/active_record/migration.rb
     # CheckPending introduced after Rails 4.0
     if Rails::VERSION::MAJOR >= 4
       ActiveRecord::Migration::CheckPending.class_eval do
         def call(env)
           if ActiveRecord::Base.connected? && connection.supports_migrations?
             mtime = ActiveRecord::Migrator.last_migration.mtime.to_i
             if @last_check < mtime
               ActiveRecord::Migration.check_pending!(connection)
               @last_check = mtime
             end
           end
           @app.call(env)
         end
       end
     end
  end
end
