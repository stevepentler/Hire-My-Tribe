require 'test_helper'

class AdminCanRateDevsTest < ActionDispatch::IntegrationTest
  test "admin can rate devs" do
    admin = create(:admin)
    dev = create(:developer)

    ApplicationController.any_instance.stubs(:current_admin).returns(admin)

    visit developer_path(dev)
    fill_in "rating[rating]", with: 5

    click_on "Update Rating"

    assert_equal developer_path(dev), current_path
    assert page.has_content? "Skill rating: 5"
  end
end
