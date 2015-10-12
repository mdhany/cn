# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



#Collector.create(email: 'melvin@cspmconsulting.com', password: 'cspm2014', password_confirmation: 'cspm2014')
#User.create(email: 'melvin@cspmconsulting.com', password: 'cspm2014', password_confirmation: 'cspm2014')

pass = '12345678'
User.create!(email: 'melvin.dani7@gmail.com', password: pass, password_confirmation: pass)
User.create!(email: 'kheilydis@cspmconsulting.com', password: pass, password_confirmation: pass)
