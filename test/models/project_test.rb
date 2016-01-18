require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should belong_to :contractor

  should have_many :project_developers
  should have_many :developers

  should define_enum_for :status
  
  should validate_presence_of(:title)
  should validate_uniqueness_of(:title)
  should validate_presence_of(:description)
end
