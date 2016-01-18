require 'test_helper'

class GuestReturnsToTribeAfterRequiredLoginTest < ActionDispatch::IntegrationTest
  test "that guest is returned to tribe after forced login" do
    dev1 = create(:developer)
    contractor = create(:contractor)

    visit developer_path(dev1)
    click_on "Add #{dev1.name} to the tribe"
    within ".right" do
      click_on "Current Tribe"
    end

    fill_in "project[title]", with: "project 1 name"
    fill_in "project[description]", with: "project 1 description"
    click_on "Start Project"

    assert_equal login_path, current_path
    within '#contractor-login-form' do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    assert_equal "/tribe", current_path

  end

  test "that guest is returned to tribe after forced account creation" do
    dev1 = create(:developer)

    visit developer_path(dev1)
    click_on "Add #{dev1.name} to the tribe"
    within ".right" do
      click_on "Current Tribe"
    end

    fill_in "project[title]", with: "project 1 name"
    fill_in "project[description]", with: "project 1 description"
    click_on "Start Project"

    assert_equal login_path, current_path
    click_on "Sign Up"

    fill_in "contractor[company_name]", with: "TestCompany"
    fill_in "contractor[first_name]", with: "TestFirstName"
    fill_in "contractor[last_name]", with: "TestLastName"
    fill_in "contractor[email]", with: "Test@Email.com"
    fill_in "contractor[password]", with: "password"
    click_on "Create Contractor Account"

    assert_equal "/tribe", current_path

  end
end
