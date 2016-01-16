require 'test_helper'

class AdminHasAPrivateDashboardTest < ActionDispatch::IntegrationTest
  test "admin login to their dashboard" do
    visit admin_login_path
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
