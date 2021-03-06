require 'test_helper'

class VisitorAddsDevelopersToCartTest < ActionDispatch::IntegrationTest
  test "a visitor can add developers to cart from index pages" do
    dev = create(:developer)

    visit developers_path
    click_on "#{dev.name}'s Bio"

    assert_equal current_path, developer_path(developers.first)

    click_on "Add #{dev.name} to the tribe"

    assert_equal current_path, developers_path

    assert page.has_content?("#{dev.name} has joined your tribe!")

    within ".right" do
      click_on "Current Tribe"
    end
    assert_equal current_path, tribe_path
    assert page.has_content?("#{dev.name}")
    assert page.has_content?("#{dev.rate.to_i}")
    assert page.has_content?("Total: $#{dev.rate.to_i}")
  end

  test "a visitor cannot add the same developer to the cart" do
    dev = create(:developer)

    visit developer_path(dev)

    assert_equal current_path, developer_path(dev)

    click_on "Add #{dev.name} to the tribe"

    visit developer_path(dev)

    refute page.has_content?("Add #{dev.name} to the tribe")
    assert page.has_content?("#{dev.name} is already in a tribe")
  end

  test "a visitor is redirected to their path of origin when adding to cart" do
    3.times do
      dev = create(:developer)
      visit specialty_path(dev.specialty)
      click_on "#{dev.name}'s Bio"
      click_on "Add #{dev.name} to the tribe"

      assert_equal specialty_path(dev.specialty), current_path
    end

    dev = create(:developer)
    visit developers_path
    click_on "#{dev.name}'s Bio"
    click_on "Add #{dev.name} to the tribe"

    assert_equal developers_path, current_path

    dev = create(:developer)
    visit specialty_path(dev.specialty)
    click_on "#{dev.name}'s Bio"
    click_on "Add #{dev.name} to the tribe"
    assert_equal specialty_path(dev.specialty), current_path
  end
end
