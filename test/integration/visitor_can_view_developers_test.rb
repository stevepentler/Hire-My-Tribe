require 'test_helper'

class VisitorCanViewDevelopersTest < ActionDispatch::IntegrationTest
  test "A visitor can click to browse available developers" do
    create_list(:developer, 2)

    visit root_path
    click_on "Browse Developers"

    assert page.has_content?("Dev1")
    assert page.has_content?("Dev2")
  end
end