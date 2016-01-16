require 'test_helper'

class VisitorRemovesDeveloperFromTribeTest < ActionDispatch::IntegrationTest
  test "visitor can remove developer from tribe prior to checkout" do
    dev1, dev2 = create_list(:developer, 2)

    visit developer_path(dev1)

    click_on "Add #{dev1.name} to the tribe"
    assert page.has_content?("#{dev1.name} has joined your tribe!")

    visit developer_path(dev2)    
    click_on "Add #{dev2.name} to the tribe"

    assert page.has_content?("#{dev2.name} has joined your tribe!")

    click_on "Current Tribe"
    assert_equal current_path, tribe_path

    assert page.has_content?("#{dev1.name}")
    assert page.has_content?("#{dev1.name}")
    within "#developer_#{dev1.name}" do
      click_on "Remove Developer"
    end

    refute page.has_content?("#{dev1.name}")
    assert page.has_content?("#{dev2.name}")

    assert_equal tribe_path, current_path

  end
end
