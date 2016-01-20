require 'test_helper'

class GuestViewsContractorsPageTest < ActionDispatch::IntegrationTest
  test "guest can see contractors index page" do
    contractor_1 = create(:contractor)
    contractor_2 = create(:contractor)

    visit contractors_path
    assert page.has_content? contractor_1.company_name
    assert page.has_content? contractor_1.first_name
    assert page.has_content? contractor_1.last_name
    assert page.has_content? contractor_2.company_name
    assert page.has_content? contractor_2.first_name
    assert page.has_content? contractor_2.last_name
  end

  test "guest can see contractor's public page" do
    contractor_1 = create(:contractor)

    visit contractors_path

    click_on "#{contractor_1.full_name} Bio"

    assert page.has_content? contractor_1.company_name
    assert page.has_content? contractor_1.first_name
    assert page.has_content? contractor_1.last_name
    assert page.has_content? contractor_1.bio
  end
end