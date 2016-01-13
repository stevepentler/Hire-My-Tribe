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

  def setup
    devs = create_list(:developer, 6)

    db = Specialty.create(name: "Database", url_name: "database")
    fe = Specialty.create(name: "Front End", url_name: "front_end")
    be = Specialty.create(name: "Back End", url_name: "back_end")

    be.developers << devs[0]
    be.developers << devs[3]

    fe.developers << devs[1]
    fe.developers << devs[4]

    db.developers << devs[2]
    db.developers << devs[5]
  end

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
