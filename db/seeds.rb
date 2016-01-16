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

Developer.create(name: "JP", last_name: "Perry", email: "hotdog1@hotmail.com", password: "$", rate: 10, specialty_id: db.id, profile_picture: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAZvAAAAJDFiY2JjNTc4LTQ0NDktNDcyYy05YzMxLTcyZmVmZDU3OTU5OA.jpg")
Developer.create(name: "Steve", last_name: "Pentler", email: "hotdog2@hotmail.com", password: "$", rate: 10, specialty_id: fe.id, profile_picture: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAZvAAAAJDFiY2JjNTc4LTQ0NDktNDcyYy05YzMxLTcyZmVmZDU3OTU5OA.jpg")
Developer.create(name: "Hector", last_name: "Huertas", email: "hotdog3@hotmail.com", password: "$", rate: 10, specialty_id: be.id, profile_picture: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAZvAAAAJDFiY2JjNTc4LTQ0NDktNDcyYy05YzMxLTcyZmVmZDU3OTU5OA.jpg")
Developer.create(name: "Aaron", last_name: "Greenspan", email: "hotdog4@hotmail.com", password: "$", rate: 10, specialty_id: be.id, profile_picture: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAAZvAAAAJDFiY2JjNTc4LTQ0NDktNDcyYy05YzMxLTcyZmVmZDU3OTU5OA.jpg")

