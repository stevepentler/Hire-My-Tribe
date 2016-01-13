require 'test_helper'

class BrowsingDevelopersBySpecialtyTest < ActionDispatch::IntegrationTest

  test "visitor can see all developers for a specific specialty" do
    dev1, dev2, dev3, dev4, dev5, dev6 = create_list(:developer, 6)

    visit developers_path
    within '.dropdown-content' do 
      click_on "Database Developers"
    end

    assert_equal "/specialties/database", current_path
    assert page.has_content?(dev3.name)
    assert page.has_content?(dev6.name)

    visit developers_path
    within '.dropdown-content' do
      click_on "Front End Developers"
    end
    assert_equal "/specialties/front_end", current_path

    assert page.has_content?(dev2.name)
    assert page.has_content?(dev5.name)

    visit developers_path
    within '.dropdown-content' do
      click_on "Back End Developers"
    end
    assert_equal "/specialties/back_end", current_path

    assert page.has_content?(dev1.name)
    assert page.has_content?(dev4.name)
  end

end