module Filter
  def self.sort_filter(params)
    developers = sort_developers(params)
    tags = selected_tags(params)

    tags.inject(developers) do |acc, tag|
      acc & tag.developers
    end
  end

  def self.sort_developers(params)
    sort[params["Sort By"]][Developer]
  end

  def self.sort
    {
      "Rate: Ascending" => lambda { |active| active.order(rate: :asc) },
      "Rate: Descending" => lambda { |active| active.order(rate: :desc) }
    }
  end

  def self.selected_tags(params)
    params["filter"] ||= {}
    params["filter"].select{ |key, val| val == "1" }.keys.map do |tag_name|
      Tag.includes(:developers).find_by(name: tag_name)
    end
  end
end
