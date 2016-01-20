module AutoSuggestionPrep
  def format_params_for_auto_suggest
    opts = params["auto_suggest"]
    {
      total_devs: opts[:total_devs].to_i,
      cost: opts[:total_cost].to_i,
      "front_end" => [ opts["front_end"].to_i, opts["front_end_lang"] ],
      "back_end" => [ opts["back_end"].to_i, opts["back_end_lang"] ],
      "database" => [ opts["database"].to_i, opts["database_lang"] ]
    }
  end

  def dev_opts(contractor_opts)
    { count: contractor_opts[:total_devs],
      threshold: 100,
      selection: Selection.tournament,
      n: 10,
      crossover: Crossover.random_rate,
      c_rate: 0.55,
      fitness: Fitness.developers_fitness(contractor_opts),
      mutation: Mutation.swap_dev,
      m_rate: 0.03,
      total: 100 }
  end
end
