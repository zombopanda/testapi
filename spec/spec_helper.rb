require 'rspec'
require 'rack/test'
require 'sinatra'
Sinatra::Application.environment = :test
ENV['RACK_ENV'] = 'test'
require File.join(File.dirname(__FILE__), '../app.rb')
ActiveRecord::Base.logger = nil