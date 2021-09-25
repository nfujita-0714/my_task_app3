# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

Label.create([
  { name: 'ラベル1' },
  { name: 'ラベル2' },
  { name: 'ラベル3' },
  { name: 'ラベル4' },
  { name: 'ラベル5' }
]) 

10.times do |n|
  Label.create!(
    name: "ラベル#{n + 1}"
  )
end

10.times do |n|
  user_id = n + 1
  Task.create!(
    title: "task#{n + 1}",
    content: "content#{n + 1}",
    limit_on: "2021-10-22 00:00:00",
    status: "未着手",
    priority: "低",
    user_id: user_id
  )
end 