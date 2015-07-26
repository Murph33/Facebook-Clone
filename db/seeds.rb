# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do |i|
  User.create(first_name: Faker::Name.first_name,
              last_name:  Faker::Name.last_name,
              birth_date:  Faker::Date.between(44.years.ago, 14.years.ago),
              password: "123",
              password_confirmation: "123",
              gender: "Male",
              remote_picture_url: "http://lorempixel.com/600/400/cats/",
              email: "#{i}@#{i}.com")
end

# LEWIS COLLIER
# Profile.where(cover_photo: nil).each {|p| p.update(remote_cover_photo_url: "http:/lorempixel.com/904/315/nightlife/")}
# User.all.each {|u| u.profile.update(remote_cover_photo_url: "http:/lorempixel.com/904/315/nightlife/"); p u.profile.errors}
# Profile.where(cover_photo: nil).each {|p| p.update(cover_photo: "http:/lorempixel.com/904/315/nightlife/"); p.save }
# u.profile.update(remote_cover_photo_url: "http://lorempixel.com/904/315/nightlife/")

# User.all.each do |u|
#   10.times do |i|
#     arr = ["food", "animals", "city", "abstract", "nature"]
#     Photo.create(user: u,
#                  remote_image_url: "http://lorempixel.com/640/480/#{arr.sample}")
#   end
# end
