require 'test_helper'

class ContractorCanDeleteProfileTest < ActionDispatch::IntegrationTest
  test "contractor can delete account once logged in" do
    visit root_path
    click_on "Sign Up"

    within "#contractor-form" do
      fill_in "Company Name", with: "Mac"
      fill_in "First Name", with: "Aaron"
      fill_in "Last Name", with: "Greenspan"
      fill_in "Email", with: "hotdogs@hotmail.com"
      fill_in "Password", with: "password"
      click_on "Create Contractor Account"
    end

    click_on "Delete Account"
    page.driver.browser.switch_to.alert.accept
    assert_equal root_path, current_path

    visit login_path
    fill_in
  end

end
# <%= link_to 'Delete',url_for(action: :delete,id: @user.id),method: :delete, data: {confirm: "Are you sure?"} %>
# page.driver.browser.switch_to.alert.accept
# page.accept_alert 'Alert text here' do
#     click_button('Search')
# end