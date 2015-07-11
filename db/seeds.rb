# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

40.times do |i|
  User.create(first_name: Faker::Name.first_name,
              last_name:  Faker::Name.last_name,
              birth_date:  Faker::Date.between(44.years.ago, 14.years.ago),
              password: "123",
              password_confirmation: "123",
              gender: "Male",
              remote_picture_url: Faker::Avatar.image,
              email: "#{i}@#{i}.com")
end
