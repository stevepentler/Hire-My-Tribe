require 'test_helper'

class AutoSuggestionTest < ActiveSupport::TestCase

  def test_existence
    assert GeneticAlgorithm
  end

  def test_auto_suggestion
    generate_devs(150)

    contractor_opts = {
      "front_end" => [3,"Javascript"],
      "back_end" => [1,"Ruby"],
      "database" => [3,"Postgresql"],
      cost: 150,
      total_devs: 7
    }

    ga = GeneticAlgorithm.new(dev_opts(contractor_opts))
    init = ga.fittest_chromosome.dna
    p Fitness.developers_fitness(contractor_opts)[init]
    p init.map{|x| {x.specialty.name => x.tags.map{|y| y.name}}}
    p "cost" + "#{init.reduce(0){|a, x| a + x.rate}}"
    p init.map{|x| x.skills_rating }

    ga.evolve(25)

    fin = ga.fittest_chromosome.dna
    p Fitness.developers_fitness(contractor_opts)[fin]
    p fin.map{|x| {x.specialty.name => x.tags.map{|y| y.name}}}
    p "cost" + "#{fin.reduce(0){|a, x| a + x.rate}}"
    p fin.map{|x| x.skills_rating }

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
