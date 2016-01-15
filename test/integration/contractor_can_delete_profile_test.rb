require 'test_helper'

class ContractorCanDeleteProfileTest < ActionDispatch::IntegrationTest
  test "contractor can delete account once logged in" do
    visit root_path
    click_on "Sign Up"

    fill_in "contractor[company_name]", with: "Mac"
    fill_in "contractor[first_name]", with: "Aaron"
    fill_in "contractor[last_name]", with: "Greenspan"
    fill_in "contractor[email]", with: "hotdogs@hotmail.com"
    fill_in "contractor[password]", with: "password"
    click_on "Create Contractor Account"

    click_on "Delete Account"
    # page.driver.browser.switch_to.alert.accept
    # assert_equal root_path, current_path

    # visit login_path
    # fill_in
  end

end
# <%= link_to 'Delete',url_for(action: :delete,id: @user.id),method: :delete, data: {confirm: "Are you sure?"} %>
# page.driver.browser.switch_to.alert.accept
# page.accept_alert 'Alert text here' do
#     click_button('Search')
# end

# page.driver.browser.switch_to.alert.accept
# page.driver.browser.switch_to.alert.dismiss