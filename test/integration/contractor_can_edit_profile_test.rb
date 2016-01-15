require 'test_helper'

class ContractorCanEditProfileTest < ActionDispatch::IntegrationTest
  test "contractor can edit account once logged in" do
    visit root_path
    click_on "Sign Up"

    within "#contractor-form" do
      fill_in "Company Name", with: "Mac"
      fill_in "First Name", with: "Aaron"
      fill_in "Last Name", with: "Greenspan"
      fill_in "Email", with: "hotdogs@hotmail.com"
      fill_in "Password", with: "password"
      click_on "Create Contractor Account"
    end

    click_on "Edit Account Information"
    assert_equal edit_contractor_path, current_path
    within "#edit-contractor-form" do
      fill_in "Company Name", with: "NotMac"
      fill_in "First Name", with: "NotAaron"
      fill_in "Last Name", with: "NotGreenspan"
      fill_in "Email", with: "Nothotdogs@hotmail.com"
      fill_in "Bio", with: "NotBio"
      click_on "Update Account"
    end

    assert_equal '/contractor', current_path
    assert page.has_content?("Account information edited!")
    assert page.has_content?("NotMac")
    assert page.has_content?("NotAaron")
    assert page.has_content?("NotGreenspan")
    assert page.has_content?("Nothotdogs@hotmail.com")
    assert page.has_content?("NotBio")
  end

end