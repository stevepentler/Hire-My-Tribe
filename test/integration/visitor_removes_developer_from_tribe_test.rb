require 'test_helper'

class VisitorRemovesDeveloperFromTribeTest < ActionDispatch::IntegrationTest
  test "visitor can remove developer from tribe prior to checkout" do
    developer1 = developers.first
    developer_last = developers.last

    visit developer_path(developer1)

    click_on "Add to tribe"
    assert page.has_content?("#{developer1.name} has joined your tribe!")

    visit developer_path(developer_last)
    
    click_on "Add to tribe"
    assert page.has_content?("#{developer_last.name} has joined your tribe!")
    
    click_on "Current Tribe"
    assert_equal current_path, tribe_path
    
    assert page.has_content?("#{developer1.name}")
    assert page.has_content?("#{developer1.name}")
    within "#developer_#{developer1.name}" do 
      click_on "Remove Developer"
    end 

    refute page.has_content?("#{developer1.name}")
    assert page.has_content?("#{developer_last.name}")

    assert_equal tribe_path, current_path

  end
end
