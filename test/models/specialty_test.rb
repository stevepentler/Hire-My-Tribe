require 'test_helper'

class SpecialtyTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
  should validate_presence_of(:url_name)
  should validate_uniqueness_of(:url_name)
end
