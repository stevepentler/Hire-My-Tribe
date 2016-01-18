require 'test_helper'

class ContractorSeesCorrectDataOnProjectCheckoutShowTest < ActionDispatch::IntegrationTest
  test "Project has correct data from tribe page" do
    tags1 = create_list(:tag, 1)
    dev1 = create(:developer, tags: tags1)
    tags2 = create_list(:tag, 2)
    dev2 = create(:developer, tags: tags2)
    contractor = create(:contractor)

    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    visit developer_path(dev1)
    click_on "Add #{dev1.name} to the tribe"
    visit developer_path(dev2)
    click_on "Add #{dev2.name} to the tribe"

    visit tribe_path
    fill_in "project[title]", with: "New Project"
    fill_in "project[description]", with: "Do Things"
    fill_in "project[dev_hours]", with: 40

    click_on "Start Project"
    project = Project.last

    assert page.has_content?("Status: Pending")
    assert page.has_content?("Description: #{project.description}")
    assert page.has_content?(dev1.name)
    assert page.has_content?(dev2.name)
    assert page.has_content?(dev1.specialty.name)
    assert page.has_content?(dev2.specialty.name)
    assert page.has_content?(dev1.rate)
    assert page.has_content?(dev2.rate)
    assert page.has_content?(dev1.tags.first.name)
    assert page.has_content?(dev2.tags.last.name)

    assert page.has_content?(project.description)
    final_rate = (dev1.rate + dev2.rate).to_i
    assert page.has_content?("Total Developer Rate/Hour: $#{final_rate}")
    assert page.has_content?("Hours Per Developer: #{project.dev_hours}")
    final_cost = project.dev_hours * final_rate
    assert page.has_content?("Final Project Cost: $#{final_cost}")
  end
end