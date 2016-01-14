require 'test_helper'

class ContractorCanLogoutTest < ActionDispatch::IntegrationTest
  test "the truth" do
    contractor = create(:contractor)
    visit login_path

    within '#contractor-login-form' do
      fill_in "Email", with: contractor.email
      fill_in "Password", with: contractor.password
      click_on "Contractor Login"
    end

    assert page.has_content?("Logged in: Contractor #{contractor.first_name}")

    click_on "Logout"

    assert_equal login_path, current_path
    assert page.has_content?("Logged out #{contractor.first_name}")
    refute page.has_content?("Logged in: Contractor #{contractor.first_name}")

    visit contractor_path
    assert page.has_content?("404")
  end
end
