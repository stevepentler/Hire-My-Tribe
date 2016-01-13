require 'test_helper'

class VisitorAddsDevelopersToCartTest < ActionDispatch::IntegrationTest
  test "a visitor can add developers to cart from index pages" do
    dev = create(:developer)

    visit developers_path #visit developer_path(@developer)
    click_on "#{dev.name} Bio"

    assert_equal current_path, developer_path(developers.first)

    click_on "Add to tribe"

    assert_equal current_path, developers_path

    assert page.has_content?("#{dev.name} has joined your tribe!")

    click_on "Current Tribe"
    assert_equal current_path, tribe_path

    assert page.has_content?("#{dev.name}")
    assert page.has_content?("#{dev.rate.to_i}")
    assert page.has_content?("Total: #{dev.rate.to_i}")
  end

  test "a visitor cannot add the same developer to the cart" do
    dev = create(:developer)

    visit developer_path(dev)

    assert_equal current_path, developer_path(dev)

    click_on "Add to tribe"

    visit developer_path(dev)

    refute page.has_content?("Add to tribe")
    assert page.has_content?("#{dev.name} is unavailable")
  end
end