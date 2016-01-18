require 'test_helper'

class ContractorViewsAllCurrentAndPastProjectsTest < ActionDispatch::IntegrationTest
  test "Contractor can view all projects associated with account" do
    dev1, dev2 = create_list(:developer, 2)

    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    project1 = create(:project, title: "First Project", description: "sample1", status: 0, contractor: contractor, developers: [dev1, dev2])
    project2 = create(:project, title: "Second Project", description: "sample2", status: 1, contractor: contractor, developers: [dev1, dev2])
    project3 = create(:project, title: "Third Project", description: "sample3", status: 2, contractor: contractor, developers: [dev1, dev2])
    project4 = create(:project, title: "Fourth Project", description: "sample4", status: 3, contractor: contractor, developers: [dev1, dev2])


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

  test "contractor can view data for invidivual project" do 
    dev1, dev2 = create_list(:developer, 2)

    contractor = create(:contractor)
    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    project1 = create(:project, title: "First Project", description: "sample1", status: 0, contractor: contractor, developers: [dev1, dev2])
    project2 = create(:project, title: "Second Project", description: "sample2", status: 1, contractor: contractor, developers: [dev1, dev2])
    project3 = create(:project, title: "Third Project", description: "sample3", status: 2, contractor: contractor, developers: [dev1, dev2])
    project4 = create(:project, title: "Fourth Project", description: "sample4", status: 3, contractor: contractor, developers: [dev1, dev2])

    contractor.projects += [project1, project2, project3, project4]

    visit contractor_projects_path

    click_on "#{project3.title}"

    assert page.has_content?(dev1.name)
    assert page.has_content?(dev1.rate)
    assert page.has_content?(dev2.name)
    assert page.has_content?(dev2.rate)

    visit contractor_project_path(project3)

    assert_equal contractor_project_path(project3.id), current_path

    assert page.has_content?(project3.status)
    assert page.has_content?(project3.total)
    assert page.has_content?(project3.created_at.to_formatted_s(:long))
    assert page.has_content?(project3.updated_at.to_formatted_s(:long))

    assert page.has_content?(dev2.rate)

  end 
end
