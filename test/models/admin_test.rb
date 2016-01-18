require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email)
  should validate_presence_of(:password)
end
