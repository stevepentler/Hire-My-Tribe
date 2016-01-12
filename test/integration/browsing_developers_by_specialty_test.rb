require 'test_helper'

class BrowsingDevelopersBySpecialtyTest < ActionDispatch::IntegrationTest

  test "visitor can see all developers for a specific specialty" do
    create_list(:developer, 6)

    visit developers_path
    click_on "Database"
    assert_equal current_path, "/developers/database_specialty"

    assert page.has_content?("Dev3")
    assert page.has_content?("Dev6")

    visit developers_path
    click_on "Front End"
    assert_equal current_path, "/developers/front_end_specialty"

    assert page.has_content?("Dev2")
    assert page.has_content?("Dev5")

    visit developers_path
    click_on "Back End"
    assert_equal current_path, "/developers/back_end_specialty"

    assert page.has_content?("Dev1")
    assert page.has_content?("Dev4")
  end

end
