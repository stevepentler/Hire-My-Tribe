require 'test_helper'

class VisitorAddsDevelopersToCartTest < ActionDispatch::IntegrationTest
  test "a visitor can add developers to cart from index pages" do
    developers = create_list(:developer, 4)

    visit developers_path #visit developer_path(@developer)
    click_on "Dev1 Bio"

    assert_equal current_path, developer_path(developers[0])

    click_on "Add to tribe"

    assert_equal current_path, developers_path

    assert page.has_content?("Dev1 has joined your tribe!")

    click_on "See current tribe"

    assert_equal current_path, tribe_path

    assert page.has_content?("Dev1")
    assert page.has_content?("10")
    assert page.has_content?("Total: 10")
  end
end

# Background: Developers, and a user that is not logged in
# As a visitor
# When I visit any page with an developer on it
# I should see a link or button for "Hire"
# When I click "Hire" for that developer
# And I click a link or button to view cart
# And my current path should be "/cart"
# And I should see a small image, name, price, and (any other attributes) for the developer I just added
# And there should be a "total" price for the cart that should be the sum of all developers in the cart
