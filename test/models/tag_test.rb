require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should have_many :developer_tags
  should have_many :developers

  should validate_presence_of :name
  should validate_uniqueness_of :name
end
