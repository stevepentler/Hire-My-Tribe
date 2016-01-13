require 'test_helper'

class BrowsingDevelopersBySpecialtyTest < ActionDispatch::IntegrationTest

  test "visitor can see all developers for a specific specialty" do
    # devs = create_list(:developer, 6)
    #
    # db = Specialty.create(name: "Database", url_name: "database")
    # fe = Specialty.create(name: "Front End", url_name: "front_end")
    # be = Specialty.create(name: "Back End", url_name: "back_end")
    # 
    # db.developers << devs[2]
    #
    # db.developers << devs[5]
    #
    # fe.developers << devs[1]
    # fe.developers << devs[4]
    #
    # be.developers << devs[0]
    # be.developers << devs[3]

    visit developers_path
    # save_and_open_page
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
