# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/allow_connection_failure/version'

Gem::Specification.new do |spec|
  spec.name          = "active_record-allow_connection_failure"
  spec.version       = ActiveRecord::AllowConnectionFailure::VERSION
  spec.authors       = ["Matt Campbell"]
  spec.email         = ["matt@zipmark.com"]

  spec.summary       = %q{Allows a Rails application to boot without connecting to a datastore.}
  spec.description   = %q{Check out the Rails PR for full details: https://github.com/rails/rails/pull/24870}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md CODE_OF_CONDUCT.md)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"

  spec.add_runtime_dependency     "rails", ">= 3.2"
end
