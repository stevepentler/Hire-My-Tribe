require 'test_helper'

class DeveloperCanLogoutTest < ActionDispatch::IntegrationTest
  test "contractor can logout" do
    developer = create(:developer)
    visit login_path

    within '#developer-login-form' do
      fill_in "session[email]", with: developer.email
      fill_in "session[password]", with: developer.password
      click_on "Developer Login"
    end

    assert page.has_content?("View Account: #{developer.name}")

    within ".left" do
      click_on "Logout"
    end

    assert_equal login_path, current_path
    assert page.has_content?("Logged out #{developer.name}")
    refute page.has_content?("View Account: #{developer.name}")

    visit "/developer"
    assert page.has_content?("404")
  end
end
