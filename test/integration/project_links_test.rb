require 'test_helper'

class ProjectLinksTest < ActionDispatch::IntegrationTest
  test "developer pages link to developer's projects" do
    dev = create(:developer)
    projects = create_list(:project, 3)

    sample_project = projects.sample

    dev.projects += projects

    visit developer_path(dev)

    projects.each do |project|
      assert page.has_content?(project.title)
    end

    click_on sample_project.title

    assert_equal project_path(sample_project), current_path

    assert page.has_content?(sample_project.title)
    assert page.has_content?(sample_project.description)
    refute page.has_content?(sample_project.status)
  end

  test "contractor pages link to contractor's projects" do
    contractor = create(:contractor)
    project = create(:project)

    contractor.projects << project

    visit contractor_path(contractor_id: contractor.id)
    assert page.has_content?(project.title)
    click_on "#{project.title}"

    assert_equal project_path(project), current_path
    assert page.has_content?(project.title)
    assert page.has_content?(project.description)
    refute page.has_content?(project.status)
  end

  test "contractor profile page links to contractor's project" do
    contractor = create(:contractor)
    project = create(:project)
    contractor.projects << project

    ApplicationController.any_instance.stubs(:current_contractor).returns(contractor)

    visit contractor_path
    assert page.has_content?(project.title)
    click_on "#{project.title}"

    assert_equal contractor_project_path(project), current_path
    assert page.has_content?(project.title)
    assert page.has_content?(project.description)
    assert page.has_content?(project.status)
  end

  test "project pages link to project's developers" do
    project = create(:project)
    dev1, dev2 = create_list(:developer, 2)
    project.developers << [dev1, dev2]

    visit project_path(project)
    click_on dev1.name

    assert_equal developer_path(dev1), current_path
    assert page.has_content?(project.title)
  end

  test "project pages link to project's contractor" do

  end
end
