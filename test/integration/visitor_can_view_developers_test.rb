require 'test_helper'

class VisitorCanViewDevelopersTest < ActionDispatch::IntegrationTest
  test "A visitor can click to browse available developers" do
    dev1, dev2 = create_list(:developer, 2)
    
    visit root_path
    click_on "All Developers"

    assert page.has_content?(dev1.name)
    assert page.has_content?(dev2.name)
  end
end
