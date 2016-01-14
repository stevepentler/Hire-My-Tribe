require 'test_helper'

class ContractorCanStartOrdersTest < ActionDispatch::IntegrationTest
  test "Contractor can start project" do
    dev1, dev2 = create_list(:developer, 2)
    
    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    tribe = PendingTribe.new([dev1.id, dev2.id])
    ApplicationController.any_instance.stubs(:current_pending_tribe_prep).returns(tribe)

    visit tribe_path 

    fill_in "Project Title", with: "New Project"
    fill_in "Project Description", with: "Do Things"
    click_on "Start Project"

    assert_equal payment_path, current_path

    click_on "Submit Payment"


    project = Project.last 
    assert_equal project_path(project), current_path

    assert page.has_content?("New Project")
    assert page.has_content?("Do Things")
    assert page.has_content?(dev1.name)
    assert page.has_content?(dev2.name)
    assert_equal 1, Project.all.count 
  end
end



# Background: An existing user that has multiple orders
# As an Authenticated User
# When I visit "/orders"
# Then I should see all orders belonging to me