ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'database_cleaner'

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def developers
    Developer.all
  end

  def teardown
    DatabaseCleaner.clean

    reset_session!

    FactoryGirl.reload
  end

end

class ActiveSupport::TestCase
 include FactoryGirl::Syntax::Methods
end
