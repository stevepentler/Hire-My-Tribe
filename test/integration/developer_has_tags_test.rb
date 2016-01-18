require 'test_helper'

class DeveloperHasTagsTest < ActionDispatch::IntegrationTest
  test "developers has many tags" do
    tags = create_list(:tag, 4)
    dev = create(:developer, tags: tags)

    ApplicationController.any_instance.stubs(:current_developer).returns(dev)

    visit '/developer'

    tags.each do |tag|
      assert page.has_content?(tag.name)
    end
  end

  test "can filter index page by single tag" do
    tags = create_list(:tag, 4)
    tag = tags.sample

    no_tag = tags - [tag]

    expected_dev1 = create(:developer, tags: [tag])
    expected_dev2 = create(:developer, tags: tags)
    not_expected_dev = create(:developer, tags: no_tag)
    developers = [expected_dev1, expected_dev2, not_expected_dev]

    visit developers_path

    developers.each do |dev|
      assert page.has_content?(dev.name)
    end

    find(:css, "#filter_#{tag.name}").set(true)
    click_on "Apply Sort"

    assert page.has_content?(expected_dev1.name)
    assert page.has_content?(expected_dev2.name)
    refute page.has_content?(not_expected_dev.name)
  end

  test "can filter index page by more than one tag" do
    tags = create_list(:tag, 4)
    tag1 = tags.sample

    leftover_tags = tags - [tag1]
    tag2 = leftover_tags.sample

    no_tags = leftover_tags - [tag2]

    expected_dev = create(:developer, tags: [tag1, tag2])
    not_expected_dev1 = create(:developer, tags: [tag1])
    not_expected_dev2 = create(:developer, tags: no_tags)

    developers = [expected_dev, not_expected_dev1, not_expected_dev2]

    visit developers_path

    developers.each do |dev|
      assert page.has_content?(dev.name)
    end

    find(:css, "#filter_#{tag1.name}").set(true)
    find(:css, "#filter_#{tag2.name}").set(true)

    click_on "Apply Sort"

    assert page.has_content?(expected_dev.name)
    refute page.has_content?(not_expected_dev1.name)
    refute page.has_content?(not_expected_dev2.name)
  end
end
