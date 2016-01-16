require 'test_helper'

class DevelopersCantAddOthersToTribeTest < ActionDispatch::IntegrationTest
  test "logged in developer cant use the tribe cart" do
    create_list(:specialty, 3)
    logged_dev, other_dev = create_list(:developer, 2)
    ApplicationController.any_instance.stubs(:current_developer).returns(logged_dev)

    visit developer_path(other_dev)

    assert page.has_content?("#{other_dev.name}")
    refute page.has_css?("#signup-button")
  end
end
