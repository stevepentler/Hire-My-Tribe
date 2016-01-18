require 'test_helper'

class GuestViewsContractorsPageTest < ActionDispatch::IntegrationTest
  test "guest can see contractors index page" do
    contractor_1 = create(:contractor)
    contractor_2 = create(:contractor, company_name: "")

    visit contractors_path

    assert page.has_content? contractor_1.company_name
    refute page.has_content? contractor_1.first_name
    refute page.has_content? contractor_1.last_name
    assert page.has_css? "#contractor-#{contractor_1.id}-logo"
    assert page.has_content? contractor_2.first_name
    assert page.has_content? contractor_2.last_name
    assert page.has_css? "#contractor-#{contractor_2.id}-logo"
  end

  test "guest can see contractor's public page" do
    contractor_1 = create(:contractor)

    visit contractors_path

    click_on contractor_1.company_name

    assert page.has_content? contractor_1.company_name
    assert page.has_content? contractor_1.first_name
    assert page.has_content? contractor_1.last_name
    assert page.has_content? contractor_1.bio
    assert page.has_css? "#contractor-#{contractor_1.id}-logo"

  end
end
