require "test_helper"

class DevelopersCantAddOthersToTribeTest < ActionDispatch::IntegrationTest
  test "logged in developer cant add devs to the tribe cart" do
    create_list(:specialty, 3)
    dev, other_dev = create_list(:developer, 2)
    ApplicationController.any_instance.stubs(:current_developer).returns(dev)

    visit developer_path(other_dev)

    assert page.has_content?("#{other_dev.name}")
    refute page.has_css?("#signup-button")
  end

  test "logged in developer cant access tribe cart" do
    create_list(:specialty, 3)
    dev = create(:developer)
    ApplicationController.any_instance.stubs(:current_developer).returns(dev)

    visit root_path

    refute page.has_content?("Current Tribe")
    refute page.has_content?("Current Tribe")

    ApplicationController.any_instance.stubs(:current_developer).returns(nil)

    visit root_path

    assert page.has_content?("Current Tribe")
  end
end
