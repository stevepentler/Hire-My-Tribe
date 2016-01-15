require 'test_helper'

class ContractorCanMakeMultipleOrders < ActionDispatch::IntegrationTest
  test "Contractor can start project" do
    dev1, dev2 = create_list(:developer, 2)

    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    tribe = PendingTribe.new([dev1.id, dev2.id])
    ApplicationController.any_instance.stubs(:current_pending_tribe).returns(tribe)

    visit tribe_path

    fill_in "Project Title", with: "New Project"
    fill_in "Project Description", with: "Do Things"
    click_on "Start Project"

    project = Project.last
    assert_equal contractor_project_path(project), current_path
    # save_and_open_page
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
end



# Background: An existing user that has multiple orders
# As an Authenticated User
# When I visit "/orders"
# Then I should see all orders belonging to me
