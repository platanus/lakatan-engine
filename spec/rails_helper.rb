require 'simplecov'
require 'coveralls'

formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)

SimpleCov.start do
  add_filter do |src|
    r = [
      src.filename =~ /lib/,
      src.filename =~ /models/,
      src.filename =~ /controllers/
    ].uniq
    r.count == 1 && r.first.nil?
  end

  add_filter 'engine.rb'
  add_filter 'spec.rb'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../spec/dummy/config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'pry'
require 'spec_helper'
require 'rspec/rails'
require 'factory_bot_rails'
require "vcr"

Dir[::Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

Lakatan.setup do |config|
  config.site_url = "https://lakatan.dev"
  config.url_prefix = "/api/v1/bearers/"
  config.authorization_token = "xxx"
end

VCR.configure do |config|
  config.cassette_library_dir = "#{::Rails.root}/spec/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = false
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/assets"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  FactoryBot.definition_file_paths = ["#{::Rails.root}/spec/factories"]
  FactoryBot.find_definitions

  config.include FactoryBot::Syntax::Methods
  config.include ActionDispatch::TestProcess
end
