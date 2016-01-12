FactoryGirl.define do
  factory :developer do
    name
    profile_picture
    specialty
    rate
  end

  sequence :name do |n|
    "Dev#{n}"
  end

  sequence :profile_picture do |n|
    "pic#{n}"
  end

  sequence :specialty, ["back_end", "front_end", "database"].cycle do |n|
    "#{n}"
  end

  sequence :rate do |n|
    n*10.0
  end

end
