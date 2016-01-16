require 'test_helper'

class DeveloperCanDeactivateAccountTest < ActionDispatch::IntegrationTest
  test "developer can deactivate account once logged in" do
    developer = create(:developer)
    visit login_path

    within '#developer-login-form' do
      fill_in "session[email]", with: developer.email
      fill_in "session[password]", with: developer.password
      click_on "Developer Login"
    end

    click_on "Deactivate Account"

    assert_equal deactivate_account_path, current_path
    fill_in "Password", with: developer.password
    click_on "Deactivate Account"

    assert_equal root_path, current_path
    assert page.has_content?("Login")
    refute page.has_content?("Logout")

    visit login_path

    within '#developer-login-form' do
      fill_in "session[email]", with: developer.email
      fill_in "session[password]", with: developer.password
      click_on "Developer Login"
    end

    assert_equal login_path, current_path
    assert page.has_content?("Inactive account. Contact admin to reactivate account.")
  end
end
