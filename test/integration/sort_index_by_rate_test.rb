require "test_helper"

class SortIndexByRateTest < ActionDispatch::IntegrationTest
  test "index page can be sorted by rate" do
    dev1 = create(:developer, rate: 0)
    dev2 = create(:developer, rate: 20)
    dev3 = create(:developer, rate: 10)

    visit developers_path

    within "div.developer-wrapper:nth-child(1)" do
      assert page.has_content?(dev1.name)
    end
    within "div.developer-wrapper:nth-child(2)" do
      assert page.has_content?(dev2.name)
    end
    within "div.developer-wrapper:nth-child(3)" do
      assert page.has_content?(dev3.name)
    end

    select "Rate: Ascending", from: "sort-by"
    click_on "Apply Sort"

    within "div.developer-wrapper:nth-child(1)" do
      assert page.has_content?(dev1.name)
    end
    within "div.developer-wrapper:nth-child(2)" do
      assert page.has_content?(dev3.name)
    end
    within "div.developer-wrapper:nth-child(3)" do
      assert page.has_content?(dev2.name)
    end

    select "Rate: Descending", from: "sort-by"
    click_on "Apply Sort"

    within "div.developer-wrapper:nth-child(1)" do
      assert page.has_content?(dev2.name)
    end
    within "div.developer-wrapper:nth-child(2)" do
      assert page.has_content?(dev3.name)
    end
    within "div.developer-wrapper:nth-child(3)" do
      assert page.has_content?(dev1.name)
    end
  end
end
