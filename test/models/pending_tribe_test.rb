require 'test_helper'

class ContractorTest < ActiveSupport::TestCase

  test "initializes with array of dev ids" do
    ids = [1,2,3]
    tribe = PendingTribe.new([1,2,3])

    assert_equal ids, tribe.developer_ids
  end

  test "initializes with empty ids if passed nothing" do
    tribe = PendingTribe.new

    assert_equal [], tribe.developer_ids


    tribe = PendingTribe.new(nil)

    assert_equal [], tribe.developer_ids
  end

  test "adds ids" do
    tribe = PendingTribe.new
    tribe.add(3)

    assert_equal [3], tribe.developer_ids
  end

  test "removes ids" do
    tribe = PendingTribe.new([3])
    tribe.remove(3)

    assert_equal [], tribe.developer_ids
  end

  test "returns developer list" do
    devs = create_list(:developer, 3)
    ids = devs.map{ |dev| dev.id}
    tribe = PendingTribe.new(ids)

    assert_equal devs, tribe.developers
  end

  test "returns developer total rate" do
    devs = create_list(:developer, 3)
    ids = devs.map{ |dev| dev.id}
    tribe = PendingTribe.new(ids)

    total = devs.reduce(0) do |acc, dev|
      acc + dev.rate.to_i
    end

    assert_equal total, tribe.total
  end

end
