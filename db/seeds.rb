# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Create main user
User.delete_all
Movie.delete_all

admin = User.create!(
  email: 'jas@example.com',
  firstname: "Jas",
  lastname: "Der",
  password: "password",
  password_confirmation: "password",
  admin: true
)

10.times do
  User.create!(
    email: Faker::Internet.safe_email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.first_name,
    password: "password",
    password_confirmation: "password",
    admin: false
  )
end

User.all.each do |u|
  2.times do
    title = Faker::Book.title
    director = Faker::Book.author
    runtime_in_minutes = (80..130).to_a.sample
    description = Faker::Hipster.paragraph(2, true)
    poster_image_url = "http://lorempixel.com/380/380/people/"
    release_date = Faker::Date.between(30.days.ago, 2.days.ago)

    u.movies.create!(
      title: title,
      director: director,
      runtime_in_minutes: runtime_in_minutes,
      description: description,
      poster_image_url: poster_image_url,
      release_date: release_date
    )
  end
end
