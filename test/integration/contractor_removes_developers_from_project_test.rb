require 'test_helper'

class ContractorRemovesDevelopersFromProjectTest < ActionDispatch::IntegrationTest
  test "Project show page has option to remove developers from project" do
    dev_1, dev_2 = create_list(:developer, 2 )

    contractor = create(:contractor)
    project = contractor.projects.create(title: "title", total: 0, description: "sample description")
    project.developers += [dev_1, dev_2]

    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    visit contractor_project_path(project)

    assert page.has_content?(dev_1.name)
    assert page.has_content?(dev_2.name)

    click_on "Remove #{dev_1.name} from project"

    assert_equal contractor_project_path(project), current_path

    refute page.has_content?(dev_1.name)
    assert page.has_content?(dev_2.name)
  end
end
