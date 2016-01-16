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
end

# As an Admin
#       When I visit "/admin/dashboard"
#       I will see a heading on the page that says "Admin Dashboard"
#       As a registered user
#       When I visit "/admin/dashboard"
#       I get a 404
#       As an unregistered user
#       When I visit "/admin/dashboard"
#       I get a 404
