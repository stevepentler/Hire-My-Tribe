class Chromosome
  attr_reader :fitness_score, :mutation_type, :built_by
  attr_accessor :dna

  def initialize(opts) # dna or range and count is minimal
    @dna = opts[:dna] || rand_dna_for_devs(opts[:count])
    @fitness_score = opts[:fitness] || Fitness.taxi_dist(Array.new(dna.length,0))
    @mutation_type = opts[:mutation] || Mutation.bit_flip
    @built_by = opts
  end

  def rand_dna(range, n)
    Array.new(n,0).map do |elt|
      rand(range.first..range.last)
    end
  end

  def rand_dna_for_devs(n)
    Array.new(n,0).map do |elt|
      all_developers.sample
    end
  end

  def all_developers
    @developers ||= Developer.all
  end

  def mutate
    dna.map! do |bp|
      s = rand(0.0 .. 1.0)
      if s < built_by[:m_rate]
        mutation_type[bp, built_by]
      else
        bp
      end
    end
  end

  def fitness
    fitness_score[dna]
  end
end
