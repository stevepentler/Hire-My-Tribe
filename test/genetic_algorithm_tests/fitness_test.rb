class FitnessTest < Minitest::Test
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
    binding.pry
    assert_equal 4, Fitness.total_with_named_language(contractor_opts, hypothesis_dna)
  end

  def total_skill_rate

  end

private

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
      Developer.create(name: "1", last_name: "1", tags: langs[0..1], email: "1", rate: 10, specialty: specialties[0]),
      Developer.create(name: "2", last_name: "2", tags: [langs[0]]+[langs[4]], email: "2", rate: 20, specialty: specialties[1]),
      Developer.create(name: "3", last_name: "3", tags: langs[2..3], email: "3", rate: 10, specialty: specialties[2]),
      Developer.create(name: "4", last_name: "4", tags: langs[3..4], email: "4", rate: 30, specialty: specialties[0]),
      Developer.create(name: "5", last_name: "5", tags: [langs[3]], email: "5", rate: 20, specialty: specialties[0]),
      Developer.create(name: "6", last_name: "6", tags: langs[1..2], email: "6", rate: 10, specialty: specialties[1]),
      Developer.create(name: "7", last_name: "7", tags: langs[1..4], email: "7", rate: 40, specialty: specialties[2])
    ]
  end
end
