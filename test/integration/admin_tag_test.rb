require 'test_helper'

class AdminTagTest < ActionDispatch::IntegrationTest
  test "admin creates a tag" do 
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    visit new_admin_tag_path

    fill_in "tag[name]", with: "Ruby"
    click_on "Submit Tag"

    tag = Tag.last

    assert_equal admin_tags_path, current_path
    assert page.has_content? tag.name
  end 
end
