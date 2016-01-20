module Filter
  def self.sort_filter(params)
    developers = sort_developers(params) || Developer.all
    tags = selected_tags(params)

    tags.inject(developers) do |acc, tag|
      acc & tag.developers
    end
  end

  def self.sort_params(params)
    params["filter"] ||= {}
    params["filter"]["sort"]
  end

  def self.sort_developers(params)
    Developer.order(active_record_sort_options(params))
  end

  def self.active_record_sort_options(params)
    [sort_params(params).split.map(&:to_sym)].to_h if sort_params(params)
  end

  def self.selected_tags(params)
    params["filter_tag_id"].keys.map do |tag_id|
      Tag.includes(:developers).find(tag_id)
    end
  end
end
