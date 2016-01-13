# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

db = Specialty.create(name: "Database", url_name: "database")
fe = Specialty.create(name: "Front End", url_name: "front_end")
be = Specialty.create(name: "Back End", url_name: "back_end")

Developer.create(name: "JP", rate: 10, specialty_id: db.id)
Developer.create(name: "Aaron", rate: 10, specialty_id: db.id)
Developer.create(name: "Hector", rate: 10, specialty_id: fe.id)
Developer.create(name: "Steve", rate: 10, specialty_id: fe.id)
Developer.create(name: "Taylor", rate: 10, specialty_id: be.id)
Developer.create(name: "Toni", rate: 10, specialty_id: be.id)
