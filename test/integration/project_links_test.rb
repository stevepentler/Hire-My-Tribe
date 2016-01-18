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

  end

  test "project pages link to project's developers" do

  end

  test "project pages link to project's contractor" do

  end
end
