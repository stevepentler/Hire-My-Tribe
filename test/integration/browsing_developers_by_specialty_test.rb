require 'test_helper'

class BrowsingDevelopersBySpecialtyTest < ActionDispatch::IntegrationTest

  test "visitor can see all developers for a specific specialty" do
    FactoryGirl.create_list(:developer, 6)

    visit developers_path
    within '#buttons-row' do
      click_on "Database Developers"
    end
    assert_equal "/specialties/database", current_path
    assert page.has_content?("Dev3")
    assert page.has_content?("Dev6")

    visit developers_path
    within '#buttons-row' do
      click_on "Front End Developers"
    end
    assert_equal "/specialties/front_end", current_path

    assert page.has_content?("Dev2")
    assert page.has_content?("Dev5")

    visit developers_path
    within '#buttons-row' do
      click_on "Back End Developers"
    end
    assert_equal "/specialties/back_end", current_path

    assert page.has_content?("Dev1")
    assert page.has_content?("Dev4")
  end

end
