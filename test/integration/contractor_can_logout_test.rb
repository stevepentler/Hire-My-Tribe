require 'test_helper'

class ContractorCanLogoutTest < ActionDispatch::IntegrationTest
  test "contractor can logout" do
    contractor = create(:contractor)
    visit login_path

    within '#contractor-login-form' do
      fill_in "session[email]", with: contractor.email
      fill_in "session[password]", with: contractor.password
      click_on "Contractor Login"
    end

    assert page.has_content?("View Account: #{contractor.first_name}")

    within ".container" do
      click_on "Logout"
    end

    assert_equal login_path, current_path
    assert page.has_content?("Logged out #{contractor.first_name}")
    refute page.has_content?("Logged in: Contractor #{contractor.first_name}")

    visit contractor_path
    assert page.has_content?("404")
  end
end