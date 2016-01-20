module ProjectCreator
  def self.generate(contractor, tribe, params)
    params.merge({
      total: tribe.total,
      contractor: contractor,
      developers: tribe.developers
    })
  end
end

# erase it