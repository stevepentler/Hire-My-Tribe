class PendingTribe
  attr_reader :developer_ids

  def initialize(developer_ids = [])
    @developer_ids = developer_ids || []
  end

  def add(developer_id)
    developer_ids << developer_id
  end

  def developers
    developer_ids.map do |dev_id|
      Developer.find(dev_id)
    end
  end

  def total
    developers.reduce(0) do |sum, developer|
      sum + developer.rate.to_i
    end
  end

  def remove(developer_id)
    developer_ids.delete_if {|id| id == developer_id}
  end
end
