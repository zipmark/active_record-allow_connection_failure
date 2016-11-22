# ActiveRecord::AllowConnectionFailure

This gem monkeypatches methods inside of `ActiveRecord::QueryCache` and
`ActiveRecord::Migration::CheckPending`.

The intention is to allow a Rails application to boot without first establishing
a database connection, enabling AR's query caching mechanism, and checking for
any pending migrations.

In practice, this is useful for situations in which you want to boot your app
and check e.g. a `/status` endpoint which does not have a database/ORM
(read: `ActiveRecord`) dependency.

## Associated `Rails` PR

For additional context, see the associated Rails
[pull request](https://github.com/rails/rails/issues/22154).

## Usage

Add this gem to your `Gemfile`:

```ruby
gem 'active_record-allow_connection_failure'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/zipmark/active_record-allow_connection_failure. This project
is intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
