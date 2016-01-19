# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

db = Specialty.create(name: "Database",
        url_name: "database",
        image: File.new("#{Rails.root}/app/assets/images/database/horse_animal_totem.png"))
fe = Specialty.create(name: "Front End",
        url_name: "front_end",
        image: File.new("#{Rails.root}/app/assets/images/back_end/Wolf_animal_totem.png"))
be = Specialty.create(name: "Back End",
        url_name: "back_end",
        image: File.new("#{Rails.root}/app/assets/images/front_end/hawk_animal_totem.png"))

bio= "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
when an unknown printer took a galley of type and scrambled it to make a type
  specimen book."

Contractor.create(first_name: "Malcolm",
                   last_name: "Middle",
                   email: "hotdog@hotmail.com",
                   password: "$",
                   bio: bio)

Developer.create(name: "JP",
                last_name: "Perry",
                email: "hotdog1@hotmail.com",
                password: "$",
                rate: 10,
                specialty: db,
                skills_rating: 2 )
Developer.create(name: "Steve",
                last_name: "Pentler",
                email: "hotdog2@hotmail.com",
                password: "$",
                rate: 20,
                specialty: fe,
                skills_rating: 3 )
Developer.create(name: "Hector",
                last_name: "Huertas",
                email: "hotdog3@hotmail.com",
                password: "$",
                rate: 30,
                specialty: be,
                skills_rating: 4 )
Developer.create(name: "Aaron",
                last_name: "Greenspan",
                email: "hotdog4@hotmail.com",
                password: "$",
                rate: 40,
                specialty: be )


Admin.create(username: 'admin', password: 'admin', email: 'admin')

ruby = Tag.create(name: "Ruby")
rust = Tag.create(name: "Rust")
js = Tag.create(name: "Javascript")

Developer.all[0].tags += [ruby]
Developer.all[1].tags += [ruby, js]
Developer.all[2].tags += [ruby, rust]
Developer.all[3].tags += [ruby, js, rust]

Project.create(title: "Little Shop", contractor: Contractor.first, description: "Make a sweet shop with an owl background!", dev_hours: 45, developers: Developer.all)

