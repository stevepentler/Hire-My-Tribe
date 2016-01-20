require "test_helper"

class SortIndexByRateTest < ActionDispatch::IntegrationTest
  test "index page can be sorted by rate" do
    dev1 = create(:developer, rate: 0)
    dev2 = create(:developer, rate: 20)
    dev3 = create(:developer, rate: 10)

    visit developers_path

    assert page.has_css?("#0-#{dev1.id}")
    assert page.has_css?("#1-#{dev2.id}")
    assert page.has_css?("#2-#{dev3.id}")

    select "Hourly Rate: Ascending", from: "filter[sort]"
    click_on "Apply Sort"

    assert page.has_css?("#0-#{dev1.id}")
    assert page.has_css?("#1-#{dev3.id}")
    assert page.has_css?("#2-#{dev2.id}")

    select "Hourly Rate: Descending", from: "filter[sort]"
    click_on "Apply Sort"

    assert page.has_css?("#0-#{dev2.id}")
    assert page.has_css?("#1-#{dev3.id}")
    assert page.has_css?("#2-#{dev1.id}")
  end
end
