require 'test_helper'

class AdminHasAPrivateDashboardTest < ActionDispatch::IntegrationTest
  test "admin login to their dashboard through contractor form" do
    admin = create(:admin)
    visit login_path
    # save_and_open_page
    within "#contractor-login-form" do
      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      click_on "Contractor Login"
    end
    # save_and_open_page
    assert_equal admin_dashboard_path, current_path
    assert page.has_content? "Admin Dashboard"

    visit root_path
    visit '/admin/dashboard'
    assert page.has_content? "Admin Dashboard"
  end

  test "admin login to their dashboard through developer form" do
    admin = create(:admin)
    visit login_path

    within "#developer-login-form" do
      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      click_on "Developer Login"
    end

    assert_equal admin_dashboard_path, current_path
    assert page.has_content? "Admin Dashboard"

    visit root_path
    visit '/admin/dashboard'
    assert page.has_content? "Admin Dashboard"
  end

  test "contractors 404 on admin dashboard" do
    contractor = create(:contractor)
    visit login_path

    within "#contractor-login-form" do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    visit '/admin/dashboard'
    # save_and_open_page
    assert page.has_content? "The page you were looking for doesn't exist"
  end

  test "developers 404 on admin dashboard" do
    developer = create(:developer)
    visit login_path

    within "#developer-login-form" do
      fill_in "session[email]", with: developer.email
      fill_in "session[password]", with: developer.password
      click_on "Developer Login"
    end

    visit '/admin/dashboard'

    assert page.has_content? "The page you were looking for doesn't exist"
  end

  test "guests 404 on admin dashboard" do
    visit '/admin/dashboard'

    assert page.has_content? "The page you were looking for doesn't exist"
  end
end
