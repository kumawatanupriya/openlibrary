require 'bundler/setup'
Bundler.require :default, :test
require 'capybara/rspec'
require 'webmock/rspec'
require File.dirname(__FILE__) + '/../openlibrary.rb'

DataMapper.setup(:default, 'mysql://root:Root@1234@localhost/openlibrary_test')
DataMapper.auto_upgrade!

Capybara.app = Sinatra::Application
Capybara.default_driver = :selenium

WebMock.disable_net_connect!(:allow_localhost => true)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.include Capybara::DSL
end
