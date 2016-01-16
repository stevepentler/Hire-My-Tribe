require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  should validate_presence_of(:description)
end
