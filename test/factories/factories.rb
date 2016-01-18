FactoryGirl.define do

  factory :contractor do
    first_name { FactoryGirl.generate(:contractor_first_name) }
    last_name { FactoryGirl.generate(:contractor_last_name) }
    email { FactoryGirl.generate(:email) }
    password "password"
    company_name "Mac"
    bio "Nothing interesting"
  end

  factory :tag do
    name { FactoryGirl.generate(:tag_name) }
  end

  factory :project do
    title { FactoryGirl.generate(:project_title) }
    description "description"
    total 40
    status 0
    created_at Time.now
    updated_at Time.now
  end

  factory :admin do
    username "admin"
    email "paco@raba.com"
    password "pass"
  end

  factory :developer do
    name
    last_name
    email { FactoryGirl.generate(:email) }
    rate
    password "password"
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

  sequence :tag_name do |n|
    "Ruby#{n}"
  end

  sequence :project_title do |n|
    "Project#{n}"
  end

  sequence :email do |n|
    "email#{n}@hotmail.com"
  end

  sequence :contractor_first_name do |n|
    "Con#{n}"
  end

  sequence :contractor_last_name do |n|
    "#{n}"
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

  sequence :last_name do |n|
    "Last#{n}"
  end

  sequence :profile_picture do |n|
    "pic#{n}"
  end

  sequence :rate do |n|
    n*10.0
  end
end
