require 'test_helper'

class ContractorCanDeactivateProfileTest < ActionDispatch::IntegrationTest
  test "contractor can deactivate account once logged in" do
    contractor = create(:contractor)
    visit login_path

    within '#contractor-login-form' do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    click_on "Deactivate Account"

    assert_equal deactivate_account_path, current_path
    fill_in "Password", with: contractor.password
    click_on "Deactivate Account"

    assert_equal root_path, current_path
    assert page.has_content?("Login")
    refute page.has_content?("Logout")

    visit login_path

    within '#contractor-login-form' do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    assert_equal login_path, current_path
    assert page.has_content?("Inactive account. Contact admin to reactivate account.")
  end

end
