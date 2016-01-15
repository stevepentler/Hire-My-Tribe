require 'test_helper'

class ContractorCanLoginTest < ActionDispatch::IntegrationTest
  test "contractor can make an account" do
    create_list(:specialty, 3)

    visit root_path
    click_on "Sign Up"

    assert page.has_content?("Login")
    refute page.has_content?("Logout")

      fill_in "contractor[company_name]", with: "Mac"
      fill_in "contractor[first_name]", with: "Aaron"
      fill_in "contractor[last_name]", with: "Greenspan"
      fill_in "contractor[email]", with: "hotdogs@hotmail.com"
      fill_in "contractor[password]", with: "password"
      click_on "Create Contractor Account"

    assert_equal '/contractor', current_path
    assert page.has_content?("Mac")
    assert page.has_content?("Aaron")
    assert page.has_content?("Greenspan")
    assert page.has_content?("hotdogs@hotmail.com")

    assert page.has_content?("Edit Account Information")
    assert page.has_content?("Deactivate Account")
    assert page.has_content?("Logout")
    refute page.has_content?("Login")

    visit root_path
    assert page.has_content?("Logout")
    refute page.has_content?("Login")
    refute page.has_content?("Sign Up")
  end

  test "contractor can login to an existing account" do
    contractor = create(:contractor)
    visit root_path
    click_on "Login"

    assert_equal current_path, login_path
    within '#contractor-login-form' do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    assert_equal current_path, contractor_path
    assert page.has_content?(contractor.first_name)
    assert page.has_content?(contractor.last_name)
    assert page.has_content?(contractor.bio)
  end

  test  "contractor see their tribes" do
    developer = create(:developer)
    contractor = create(:contractor)

    visit developer_path(developer)
    click_on "Add to tribe"

    visit login_path

    within '#contractor-login-form' do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    visit tribe_path

    assert page.has_content?(developer.name)
    assert page.has_content?(developer.rate)
    assert page.has_content?("Total")
  end

  test "unregistered visit can not start project and redirected to sign_up_path" do

    visit tribe_path
    click_on "Start Project"

    assert_equal login_path, current_path
  end

  test "contractor cannot create account or login when already logged in" do
    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    visit login_path
    assert_equal root_path, current_path
    assert page.has_content?("Already logged in!")

    visit sign_up_path
    assert_equal root_path, current_path
    assert page.has_content?("Already logged in!")
  end

end