require 'test_helper'

class ContractorEndsProjectTest < ActionDispatch::IntegrationTest
  test "contractor completes project" do
    devs = create_list(:developer, 2, status: "unavailable")
    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)
    project = create(:project, contractor: contractor, developers:devs, status: 1)

    assert_equal "Paid & Active", project.status
    devs.each do |dev|
      assert_equal "unavailable", dev.status
    end

    visit contractor_project_path(project)
    refute page.has_content? "Submit Payment"
    click_on "Complete Project"
    project.reload

    assert_equal contractor_project_path(project), current_path
    assert page.has_content? "Project Complete - Congratulations!"
    assert_equal "Completed", project.status
    devs.each do |dev|
      dev.reload
      assert_equal "available", dev.status
    end
  end

  test "contractor cancels project" do
    devs = create_list(:developer, 2, status: "unavailable")
    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)
    project = create(:project, contractor: contractor, developers:devs, status: 1)

    assert_equal "Paid & Active", project.status
    devs.each do |dev|
      assert_equal "unavailable", dev.status
    end

    visit contractor_project_path(project)
    refute page.has_content? "Submit Payment"
    click_on "Cancel Project"
    project.reload

    assert_equal contractor_project_path(project), current_path
    assert page.has_content? "The Project has been cancelled"
    assert_equal "Cancelled", project.status
    devs.each do |dev|
      dev.reload
      assert_equal "available", dev.status
    end
  end
end
