require 'test_helper'

class DeveloperCanLoginToAccountTest < ActionDispatch::IntegrationTest
  test "developer can make an account" do
    create_list(:specialty, 3)

    visit root_path
    click_on "Sign Up"

    assert page.has_content?("Login")
    refute page.has_content?("Logout")

      fill_in "developer[name]", with: "Aaron"
      fill_in "developer[last_name]", with: "Greenspan"
      fill_in "developer[email]", with: "hotdogs@hotmail.com"
      select "Database", :from => "form-value"
      fill_in "developer[password]", with: "password"
      click_on "Create Developer Account"

    assert_equal '/developer', current_path
    assert page.has_content?("Aaron")
    assert page.has_content?("Greenspan")
    assert page.has_content?("hotdogs@hotmail.com")

    assert page.has_content?("Logout")
    refute page.has_content?("Login")

    visit root_path

    assert page.has_content?("Logout")
    refute page.has_content?("Login")
    refute page.has_content?("Sign Up")
  end
end
