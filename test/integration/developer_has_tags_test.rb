require 'test_helper'

class DeveloperHasTagsTest < ActionDispatch::IntegrationTest
  test "developers has many tags" do
    tags = create_list(:tag, 4)
    dev = create(:developer, tags: tags)

    ApplicationController.any_instance.stubs(:current_developer).returns(dev)

    visit '/developer'

    tags.each do |tag|
      assert page.has_content?(tag.name)
    end
  end
end
