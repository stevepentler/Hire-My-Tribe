class FitnessTest < ActionDispatch::IntegrationTest
  def test_exists
    assert Fitness
  end

  def test_computes_taxi_distance
    assert_equal 4, Fitness.taxi_dist([0,0,0,0])[[1,1,1,1]]
    assert_equal 9, Fitness.taxi_dist([1,3,2,1])[[0,-2,4,2]]
  end

  def test_computes_euc_distance
    assert_equal 2**(0.5), Fitness.euc_dist([0,0])[[1,1]]
    assert_equal 5, Fitness.euc_dist([3,3])[[0,-1]]
  end

  def test_total_with_named_language
    assert_equal 4, Fitness.total_with_named_language(contractor_opts, hypothesis_dna)
  end

  def test_total_skill_rate
    assert_equal 17, Fitness.total_skill_rate(hypothesis_dna)
  end

  def test_total_cost_difference
    assert_equal 10, Fitness.total_cost_difference(contractor_opts, hypothesis_dna)
  end

  def test_team_breakdown_difference
    assert_equal -6, Fitness.team_breakdown_difference(contractor_opts, hypothesis_dna)
  end

  def test_developers_fitness
    assert_equal 11.399999999999999, Fitness.developers_fitness(contractor_opts)[hypothesis_dna]
  end

  def test_developers_fitness_scaling
    bad = Fitness.developers_fitness(contractor_opts)[hypothesis_dna]
    good = Fitness.developers_fitness(contractor_opts)[good_hypothesis_dna]
    assert bad < good
  end

  def contractor_opts
    {
      "front_end" => [3,"Javascript"],
      "back_end" => [1,"Ruby"],
      "database" => [3,"Postgresql"],
      cost: 150
    }
  end

  def langs
    [
      Tag.create(name: "Javascript"),
      Tag.create(name: "Ruby"),
      Tag.create(name: "Postgresql"),
      Tag.create(name: "Elixir"),
      Tag.create(name: "Sass")
    ]
  end

  def specialties
    [
      Specialty.find_or_create_by(url_name: "back_end"),
      Specialty.find_or_create_by(url_name: "front_end"),
      Specialty.find_or_create_by(url_name: "database")
    ]
  end

  def hypothesis_dna
    [
      Developer.create(name: "1", last_name: "1", tags: langs[0..1], email: "1", rate: 10, specialty: specialties[0], skills_rating: 0),
      Developer.create(name: "2", last_name: "2", tags: [langs[0]]+[langs[4]], email: "2", rate: 20, specialty: specialties[1], skills_rating: 1),
      Developer.create(name: "3", last_name: "3", tags: langs[2..3], email: "3", rate: 10, specialty: specialties[2], skills_rating: 2),
      Developer.create(name: "4", last_name: "4", tags: langs[3..4], email: "4", rate: 30, specialty: specialties[0], skills_rating: 3),
      Developer.create(name: "5", last_name: "5", tags: [langs[3]], email: "5", rate: 20, specialty: specialties[0], skills_rating: 2),
      Developer.create(name: "6", last_name: "6", tags: langs[1..2], email: "6", rate: 10, specialty: specialties[1], skills_rating: 5),
      Developer.create(name: "7", last_name: "7", tags: langs[1..4], email: "7", rate: 40, specialty: specialties[2], skills_rating: 4)
    ]
  end

  def good_hypothesis_dna
    [
      Developer.create(name: "1", last_name: "1", tags: langs[0..1], email: "1", rate: 10, specialty: specialties[0], skills_rating: 4),
      Developer.create(name: "2", last_name: "2", tags: [langs[0]]+[langs[4]], email: "2", rate: 20, specialty: specialties[1], skills_rating: 3),
      Developer.create(name: "3", last_name: "3", tags: langs[2..3], email: "3", rate: 10, specialty: specialties[2], skills_rating: 2),
      Developer.create(name: "4", last_name: "4", tags: langs[3..4], email: "4", rate: 30, specialty: specialties[1], skills_rating: 3),
      Developer.create(name: "5", last_name: "5", tags: [langs[3]], email: "5", rate: 20, specialty: specialties[0], skills_rating: 2),
      Developer.create(name: "6", last_name: "6", tags: langs[1..2], email: "6", rate: 10, specialty: specialties[1], skills_rating: 5),
      Developer.create(name: "7", last_name: "7", tags: langs[1..4], email: "7", rate: 40, specialty: specialties[2], skills_rating: 4)
    ]
  end
end
