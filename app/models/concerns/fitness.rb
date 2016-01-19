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

  def self.developers_fitness(contractor_opts)
    Proc.new do |dna|
      correct_language_bonus = total_with_named_language(contractor_opts, dna)*2.5
      skill_bonus = total_skill_rate(dna)/3.0
      cost_bonus = total_cost_difference(contractor_opts, dna)/6.5
      team_breakdown_penalty = team_breakdown_difference(contractor_opts, dna)
      repeating_member_bonus = 7 * Chromosome.new(dna: dna).no_repeats_bin?

      correct_language_bonus + skill_bonus + cost_bonus + team_breakdown_penalty +
      repeating_member_bonus
    end
  end

private

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
      acc
    end

    expected_team = contractor_opts.map do |key, val|
      [key, val[0]] if key != :cost
    end.reject{|x| x.nil?}.to_h

    differences = actual_team.merge(expected_team){|k, v1, v2| (v1-v2)**2}
    differences.reduce(0) do |acc, k_v|
      acc - k_v[1]
    end
  end
end
