require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  should have_secure_password

  should belong_to :specialty
  should have_many :project_developers
  should have_many :developer_tags
  should have_many :projects
  should have_many :tags

  should validate_presence_of(:name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email)
  should validate_presence_of(:rate)
  should validate_numericality_of(:rate)
  should validate_presence_of(:specialty_id)
  should validate_presence_of(:password)
end
