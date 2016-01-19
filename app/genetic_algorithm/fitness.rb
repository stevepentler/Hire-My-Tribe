module Fitness
  def self.taxi_dist(array)
    Proc.new do |dna|
      dna.each_index.reduce(0) do |acc, i|
        acc + (array[i] - dna[i]).abs
      end
    end
  end

  def self.summation_dist(array)
    Proc.new do |dna|
      (dna.reduce(&:+) - array.reduce(&:+)).abs
    end
  end

  def self.euc_dist(array)
    Proc.new do |dna|
      dna.each_index.reduce(0) do |acc, i|
        acc + (array[i]-dna[i])**2
      end**(0.5)
    end
  end

# {"front_end" => [total,language ], back_end: [total, language], database: [total, language], cost: pph}

  def self.developers_fitness(contractor_opts)
    Proc.new do |dna|
      correct_language_bonus = total_with_named_language(contractor_opts, dna)
      skill_bonus = total_skill_rate(dna)/5.0
      cost_bonus = total_cost_difference(contractor_opts, dna)
      team_breakdown_bonus = team_breakdown_difference(contractor_opts, dna)
    end
  end

  def self.total_with_named_language(contractor_opts, dna)
    dna.select do |dev|
      languages = dev.tags.map{|x| x.name}
      languages.include?(contractor_opts[dev.specialty.url_name][1])
    end.count
  end

  def self.total_skill_rate(dna)
    dna.reduce(0) do |acc, dev|
      acc + dev.skills_rating
    end
  end

  def self.total_cost_difference(contractor_opts, dna)
    actual_cost = dna.map{|dev| dev.rate}.reduce(&:+)
    expected_cost = contractor_opts[:cost]
    expected_cost - actual_cost
  end

  def self.team_breakdown_difference(contractor_opts, dna)
    actual_team = dna.reduce(Hash.new(0)) do |acc, dev|
      acc[dev.specialty.url_name] += 1
    end

    expected_team = contractor_opts.map do |key, val|
      [key, val[0]] if key != :cost
    end.to_h

    differences = actual_team.merge(expected_team){|k, v1, v2| (v1-v2)**2}
    differences.reduce(0) do |acc, k, v|
      acc + v
    end
  end
end
