FactoryGirl.define do

  factory :developer do
    name
    profile_picture
    rate
    specialty
  end

  factory :specialty do
    initialize_with { Specialty.find_or_create_by(
      name: FactoryGirl.generate(:specialty_name),
      url_name: FactoryGirl.generate(:url_name),
      description: "sample description"
      )
    }
  end

  sequence :specialty_name, ["Back End", "Front End", "Database"].cycle do |n|
    n
  end

  sequence :url_name, ["back_end", "front_end", "database"].cycle do |n|
    n
  end

  sequence :name do |n|
    "Dev#{n}"
  end

  sequence :profile_picture do |n|
    "pic#{n}"
  end

  sequence :rate do |n|
    n*10.0
  end
end
