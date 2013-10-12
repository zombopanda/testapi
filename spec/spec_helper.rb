require 'rspec'
require 'rack/test'
require 'sinatra'
require 'database_cleaner'
require 'sinatra/activerecord/rake'

Sinatra::Application.environment = :test
ENV['RACK_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '../app.rb')

set :database, 'sqlite3:///db/test.db'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:all) do
    ActiveRecord::Base.logger = nil
    Sinatra::ActiveRecordTasks.migrate
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end