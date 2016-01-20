class TribesController < ApplicationController
  include AutoSuggestionPrep

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
    if invalid_auto_suggest?(contractor_opts)
      redirect_to tribe_path
      flash[:error] = "Invalid parameters for auto suggest."
    else
      fittest = GeneticAlgorithm.new(dev_opts(contractor_opts)).evolve(25)
      @pending_tribe = PendingTribe.new(fittest.dna.map{|dev| dev.id})
      @project = Project.new
      render :show
    end
  end

private

  def invalid_auto_suggest?(contractor_opts)
    less_than_one_dev?(contractor_opts) || specialists_dont_add_to_total?(contractor_opts)
  end

  def less_than_one_dev?(contractor_opts)
    contractor_opts[:total_devs] <= 0
  end

  def specialists_dont_add_to_total?(contractor_opts)
    contractor_opts["front_end"][0] + contractor_opts["back_end"][0] +
    contractor_opts["database"][0] != contractor_opts[:total_devs]
  end
end
