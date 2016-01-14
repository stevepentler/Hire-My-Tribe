require 'test_helper'

class ContractorRemovesDevelopersFromProjectTest < ActionDispatch::IntegrationTest
  test "Project show page has option to remove developers from project" do
    devs = create_list(:developer, 2 )

    contractor = create(:contractor)
    project = contractor.projects.create(title: "title", total: 0, description: "")
    project.developers += devs

    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    visit contractor_project_path(project)

    assert page.has_content?(devs[0].name)
    assert page.has_content?(devs[1].name)

    click_on "Remove #{devs[0].name} from project"

    assert_equal contractor_project_path(project), current_path

    refute page.has_content?(devs[0].name)
    assert page.has_content?(devs[1].name)
  end
end
