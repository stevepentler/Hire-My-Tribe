require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email)
  should validate_presence_of(:rate)
  should validate_presence_of(:specialty_id)
  should validate_presence_of(:password)
end
