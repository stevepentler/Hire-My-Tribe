require 'test_helper'

class SearchDevsByNameTest < ActionDispatch::IntegrationTest
  test 'user searchs dev index by developer name' do 
  create_list(:developer, 10)

    visit developers_path

    fill_in "developer[filter_name]", with: "Dev1"
save_and_open_page
    assert_equal developers_path, current_path
    assert page.has_content?("Dev1")
    refute page.has_content?("Dev2")
    refute page.has_content?("Dev3")
    refute page.has_content?("Dev4")
    refute page.has_content?("Dev5")
    refute page.has_content?("Dev6")
    refute page.has_content?("Dev7")
    refute page.has_content?("Dev8")
    refute page.has_content?("Dev9")
  end 
end
