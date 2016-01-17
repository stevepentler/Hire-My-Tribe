require "test_helper"

class DeveloperCanLoginToAccountTest < ActionDispatch::IntegrationTest
  test "developer can make an account" do
    create_list(:specialty, 3)

    visit root_path
    click_on "Sign Up"

    assert page.has_content?("Login")
    refute page.has_content?("Logout")

    fill_in "developer[name]", with: "Aaron"
    fill_in "developer[last_name]", with: "Greenspan"
    fill_in "developer[email]", with: "hotdogs@hotmail.com"
    fill_in "developer[rate]", with: 10
    
    select "Database", from: "form-value"

    fill_in "developer[password]", with: "password"
    click_on "Create Developer Account"

    assert_equal "/developer", current_path
    assert page.has_content?("Aaron")
    assert page.has_content?("Greenspan")
    assert page.has_content?("hotdogs@hotmail.com")

    assert page.has_content?("Logout")
    refute page.has_content?("Login")

    visit root_path

    assert page.has_content?("Logout")
    refute page.has_content?("Login")
    refute page.has_content?("Sign Up")
  end

  test "developer can login to account" do
    create_list(:specialty, 3)

    dev = create(:developer)
    visit root_path
    click_on "Login"

    assert_equal current_path, login_path
    within '#developer-login-form' do
      fill_in "session[email]", with: dev.email
      fill_in "session[password]", with: dev.password
      click_on "Developer Login"
    end

    assert_equal "/developer", current_path
    assert page.has_content?(dev.name)
    assert page.has_content?(dev.last_name)
    assert page.has_content?(dev.bio)
  end

  test "new developer is included in developers pages" do
    specialty = create_list(:specialty, 3).sample

    visit sign_up_path

    fill_in "developer[name]", with: "Aaron"
    fill_in "developer[last_name]", with: "Greenspan"
    fill_in "developer[email]", with: "hotdogs@hotmail.com"
    fill_in "developer[rate]", with: 10
    select "#{specialty.name}", from: "form-value"
    fill_in "developer[password]", with: "password"
    click_on "Create Developer Account"

    visit specialty_path(specialty)

    assert page.has_content? "Aaron"
  end
end
