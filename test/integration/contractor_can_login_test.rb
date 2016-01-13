require 'test_helper'

class ContractorCanLoginTest < ActionDispatch::IntegrationTest
  test "contractor can make an account" do
    visit root_path
    click_on "Sign Up"

    assert page.has_content?("Login")
    refute page.has_content?("Logout")

    within "#contractor-form" do

      fill_in "Company Name", with: "Mac"
      fill_in "First Name", with: "Aaron"
      fill_in "Last Name", with: "Greenspan"
      fill_in "Email", with: "hotdogs@hotmail.com"
      fill_in "Password", with: "password"
      click_on "Create Contractor Account"
    end
    # contractor = Contractor.last

    assert_equal '/contractor', current_path
    assert page.has_content?("Mac")
    assert page.has_content?("Aaron")
    assert page.has_content?("Greenspan")
    assert page.has_content?("hotdogs@hotmail.com")

    assert page.has_content?("Edit Account Information")
    assert page.has_content?("Delete Account")

    assert page.has_content?("Logout")
    refute page.has_content?("Login")

    visit root_path

    assert page.has_content?("Logout")
    refute page.has_content?("Login")
  end





# And when I visit "/cart"
# Then I should see all of the data that was there when I was not logged in
# When I click "Logout"
# Then I should see see "Login"
# And I should not see "Logout"


  test "contractor can login to an existing account" do

  end
end
