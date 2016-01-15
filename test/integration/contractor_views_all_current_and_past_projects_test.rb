require 'test_helper'

class ContractorViewsAllCurrentAndPastProjectsTest < ActionDispatch::IntegrationTest
  test "Contractor can view all projects associated with account" do
    dev1, dev2 = create_list(:developer, 2)

    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    project1 = create(:project, status: 0)
    project2 = create(:project, status: 1)
    project3 = create(:project, status: 2)
    project4 = create(:project, status: 3)

    contractor.projects += [project1, project2, project3, project4]

    visit contractor_projects_path

    within "#project-#{project1.id}" do
      assert page.has_content?(project1.title)
      assert page.has_content?(project1.status)
      assert page.has_content?(project1.description)
      assert page.has_content?(project1.total)
    end

    within "#project-#{project2.id}" do
      assert page.has_content?(project2.title)
      assert page.has_content?(project2.status)
      assert page.has_content?(project2.description)
      assert page.has_content?(project2.total)
    end

    within "#project-#{project3.id}" do
      assert page.has_content?(project3.title)
      assert page.has_content?(project3.status)
      assert page.has_content?(project3.description)
      assert page.has_content?(project3.total)
    end

    within "#project-#{project4.id}" do
      assert page.has_content?(project4.title)
      assert page.has_content?(project4.status)
      assert page.has_content?(project4.description)
      assert page.has_content?(project4.total)
    end
  end


end
