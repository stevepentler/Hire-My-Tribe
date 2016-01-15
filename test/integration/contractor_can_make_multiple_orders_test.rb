require 'test_helper'

class ContractorCanMakeMultipleOrders < ActionDispatch::IntegrationTest
  test "Contractor can start project" do
    dev1, dev2 = create_list(:developer, 2)

    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    tribe = PendingTribe.new([dev1.id, dev2.id])
    ApplicationController.any_instance.stubs(:current_pending_tribe).returns(tribe)

    visit tribe_path

    fill_in "project[title]", with: "New Project"
    fill_in "project[description]", with: "Do Things"
    click_on "Start Project"

    project = Project.last

    assert_equal "Pending", project.status
    assert_equal contractor_project_path(project), current_path
    assert page.has_content?("New Project")
    assert page.has_content?("Do Things")
    assert page.has_content?(dev1.name)
    assert page.has_content?(dev2.name)
    assert_equal 1, Project.all.count

    click_on "Submit Payment"

    assert_equal contractor_project_payment_path(project), current_path

    click_on "Make Payment"

    assert_equal contractor_project_path(project), current_path

  end

  test "when contractor starts project, current tribe resets to empty" do
    dev = create(:developer)

    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    visit developer_path(dev)
    click_on "Add to tribe"

    visit tribe_path
    click_on "Start Project"

    visit tribe_path
    refute page.has_content?(dev.name)
  end
end



# Background: An existing user that has multiple orders
# As an Authenticated User
# When I visit "/orders"
# Then I should see all orders belonging to me
