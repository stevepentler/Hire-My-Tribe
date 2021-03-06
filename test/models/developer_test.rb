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
  should validate_inclusion_of(:skills_rating).in_range([0,1,2,3,4,5])
  should validate_presence_of(:specialty_id)
  should validate_presence_of(:password)


  test "returns only available developers" do
    dev1, dev2 = create_list(:developer,2)
    dev2.status = "unavailable"
    dev2.save

    assert_equal [dev1], Developer.available
  end
end
