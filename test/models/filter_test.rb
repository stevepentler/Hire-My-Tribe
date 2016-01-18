require 'test_helper'

class FilterTest < ActiveSupport::TestCase

  test "existance" do
    assert Filter
  end
  
  test "it filters developers by tags and order" do
    tag_1, tag_2, tag_3 = create_list(:tag, 3)
    dev_1 = create(:developer, tags: [tag_1, tag_2, tag_3])
    create(:developer, tags: [tag_1, tag_2])
    dev_3 = create(:developer, tags: [tag_2, tag_3])

    params = {}
    params["Sort By"] = "Rate: Descending"
    params["filter"] = {
      tag_1.name => "0", tag_2.name => "1", tag_3.name => "1"
    }
    developers = Filter.sort_filter(params)

    assert_equal developers.count, 2
    assert_equal developers.first.name, dev_3.name
    assert_equal developers.last.name, dev_1.name
  end
end
