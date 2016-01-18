require 'test_helper'

class FilterTest < ActiveSupport::TestCase

  test "existance" do
    assert Filter
  end

  def test_extracts_tags
    params = {}
    Filter.selected_tags()
  end

end
