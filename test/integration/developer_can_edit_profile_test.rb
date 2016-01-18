require 'test_helper'

class DeveloperCanEditProfileTest < ActionDispatch::IntegrationTest
  test "contractor can edit account once logged in" do
    specialties = create_list(:specialty, 3)
    dev = create(:developer, name: "Aaron",
                        last_name: "G",
                        specialty: specialties.first,
                        email: "hotdogs@hotmail.com",
                        password: "password")

    ApplicationController.any_instance.stubs(:current_developer).returns(dev)
    other_specialty = specialties.last

    visit "/developer"

    click_on "Edit Account"

    assert_equal edit_developer_path, current_path

    within ".edit-developer" do
      fill_in "developer[name]", with: "NotAaron"
      fill_in "developer[last_name]", with: "NotG"
      fill_in "developer[email]", with: "Nothotdogs@hotmail.com"
      select "#{other_specialty.name}", from: "form-value"
      fill_in "Bio", with: "NotBio"
      click_on "Update Developer Account"
    end

    assert_equal "/developer", current_path
    assert page.has_content?("Account information edited!")
    assert page.has_content?("NotAaron")
    assert page.has_content?("NotG")
    assert page.has_content?("Nothotdogs@hotmail.com")
    assert page.has_content?("NotBio")
  end
end
