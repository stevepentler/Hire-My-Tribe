require 'test_helper'

class ContractorTest < ActiveSupport::TestCase
  should have_secure_password

  should have_many :projects

  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email)
  should validate_presence_of(:status)
  should validate_presence_of(:password)
end
