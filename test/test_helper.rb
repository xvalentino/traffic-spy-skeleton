ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'capybara'
require 'database_cleaner'
require 'minitest/pride'
require 'pry'


DatabaseCleaner.strategy = :truncation, {:except => %w[public.schema_migrations]}


Capybara.app = TrafficSpy::Server

class BaseTest < Minitest::Test

  def teardown
    DatabaseCleaner.clean
  end
end

