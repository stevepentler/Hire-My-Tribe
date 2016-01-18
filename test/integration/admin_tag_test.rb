require 'test_helper'

class AdminTagTest < ActionDispatch::IntegrationTest
  test "admin creates a tag" do 
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    visit admin_dashboard_path 

    click_on "Tags"
    assert_equal admin_tags_path, current_path

    click_on "Add a Tag"
    assert_equal new_admin_tag_path, current_path

    fill_in "tag[name]", with: "Ruby"
    click_on "Submit Tag"

    tag = Tag.last
    assert_equal admin_tags_path, current_path
    assert page.has_content? tag.name
  end 

  test "admin updates a tag" do 
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    original_tag = Tag.create(name: "Z")

    visit admin_tags_path

    click_on "Edit Tag"

    assert_equal edit_admin_tag_path(original_tag), current_path
    fill_in "tag[name]", with: "Ruby"
    click_on "Submit Tag"

    assert_equal admin_tags_path, current_path
    assert page.has_content?("Ruby")
    refute page.has_content?("Z")
  end

  test "admin removes a tag" do 
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    tag = Tag.create(name: "Ruby")

    visit admin_tags_path

    click_on "Remove Tag"

    assert_equal admin_tags_path, current_path
    refute page.has_content?("Ruby")
    assert page.has_content?("All Tags")
  end
end
