class TribesController < ApplicationController

  def create
    developer = Developer.find(params[:developer_id])
    flash[:notice] = "#{developer.name} has joined your tribe!"
    current_pending_tribe.add(developer.id)

    if current_specialty
      redirect_to specialty_path(current_specialty)
    else
      redirect_to developers_path
    end
  end

  def show
    render file: "public/404.html" if current_developer
    @project = Project.new
  end

  def destroy
    current_pending_tribe.remove(params[:developer_id].to_i)
    redirect_to tribe_path
  end

  def auto_suggest
    contractor_opts = format_params_for_auto_suggest
    ga = GeneticAlgorithm.new(dev_opts(contractor_opts))
    binding.pry
    ga.evolve(25)
    binding.pry
    @pending_tribe = PendingTribe.new(ga.fittest_chromosome.dna.map{|dev| dev.id})
    @project = Project.new
    render :show
  end

private

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
      total: 100
    }
  end
end
