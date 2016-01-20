ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'database_cleaner'
require 'mocha/mini_test'

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

  def teardown
    DatabaseCleaner.clean
  end

  def gen_tags
    Tag.create(name: "Postgresql")
    Tag.create(name: "Ruby")
    Tag.create(name: "Rust")
    Tag.create(name: "Javascript")
    Tag.create(name: "Rails")
    Tag.create(name: "Phoenix")
    Tag.create(name: "css")
    Tag.create(name: "Elixir")
    Tag.create(name: "Haskell")
    Tag.create(name: "Elm")
    Tag.create(name: "Go")
    Tag.create(name: "Java")
    Tag.create(name: "SQlite3")
  end

  def gen_specialties
    Specialty.create(name: "Database", url_name: "database")
    Specialty.create(name: "Front End", url_name: "front_end")
    Specialty.create(name: "Back End", url_name: "back_end")
  end

  def generate_devs(n)
    gen_tags
    gen_specialties

    tags = Tag.all
    specialties = Specialty.all
    n.times do |i|
      m = rand(0..3)
      skilled_tags = [tags.shuffle[0..m]].flatten
      Developer.create(name: "#{i}",
                      last_name: "#{i}",
                      email: "#{i}",
                      rate: rand(10..50),
                      specialty: specialties.sample,
                      tags: skilled_tags,
                      password: "password",
                      skills_rating: rand(0..5))
    end
  end


  class ActionController::TestCase
    include FactoryGirl::Syntax::Methods

    def teardown
      DatabaseCleaner.clean
    end

    def gen_tags
      Tag.create(name: "Postgresql")
      Tag.create(name: "Ruby")
      Tag.create(name: "Rust")
      Tag.create(name: "Javascript")
      Tag.create(name: "Rails")
      Tag.create(name: "Phoenix")
      Tag.create(name: "css")
      Tag.create(name: "Elixir")
      Tag.create(name: "Haskell")
      Tag.create(name: "Elm")
      Tag.create(name: "Go")
      Tag.create(name: "Java")
      Tag.create(name: "SQlite3")
    end

    def gen_specialties
      Specialty.create(name: "Database", url_name: "database")
      Specialty.create(name: "Front End", url_name: "front_end")
      Specialty.create(name: "Back End", url_name: "back_end")
    end

    def generate_devs(n)
      gen_tags
      gen_specialties

      tags = Tag.all
      specialties = Specialty.all
      n.times do |i|
        m = rand(0..3)
        skilled_tags = [tags.shuffle[0..m]].flatten
        Developer.create(name: "#{i}",
                        last_name: "#{i}",
                        email: "#{i}",
                        rate: rand(10..50),
                        specialty: specialties.sample,
                        tags: skilled_tags,
                        password: "password",
                        skills_rating: rand(0..5))
      end
    end
  end
end
