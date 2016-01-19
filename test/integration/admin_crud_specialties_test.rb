require 'test_helper'

class AdminCrudSpecialtiesTest < ActionDispatch::IntegrationTest
  test "admin creates a specialty" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    visit 'admin/dashboard'
    click_on "Specialties"
    click_on "New Specialty"

    fill_in "Name", with: "database"
    fill_in "Description", with: ""
    fill_in "Url name", with: "database"
    attach_file "Image", "test/test_assets/piglet.jpg"
    click_on "Create Specialty"

    specialty = Specialty.last

    assert_equal admin_specialties_path, current_path
    assert page.has_content? specialty.name
    assert page.has_css? "#database-image"
  end

  test "admin creates a specialty without picture" do
    admin = create(:admin)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    visit new_admin_specialty_path

    fill_in "Name", with: "database"
    fill_in "Description", with: ""
    fill_in "Url name", with: "database"
    click_on "Create Specialty"

    specialty = Specialty.last

    assert_equal admin_specialties_path, current_path
    assert page.has_content? specialty.name
    assert page.has_css? "#database-image"
  end

  test "admin edits a specialty" do
    admin = create(:admin)
    specialty = create(:specialty)
    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    visit 'admin/dashboard'
    click_on "Specialties"
    within "#specialty-#{specialty.url_name}" do
      click_on "Edit Specialty"
    end

    fill_in "Name", with: "design"
    fill_in "Description", with: "Not a proper description"
    fill_in "Url name", with: "design"
    attach_file "Image", "test/test_assets/piglet.jpg"
    click_on "Update Specialty"

    specialty.reload

    assert_equal admin_specialties_path, current_path
    assert page.has_content? specialty.name
    assert page.has_css? "##{specialty.name}-image"
  end
end
