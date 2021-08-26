# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do |n|
  name = ('A'..'Z').to_a.sample + "." + ('A'..'Z').to_a.sample
  area = [8, 9, 10, 11, 12, 13, 14, 25, 26, 27, 28, 29, 30]
  User.create(
    name: name,
    age: rand(18..60),
    target: Faker::Boolean.boolean,
    height: rand(150..180),
    area: area.sample,
    experience: rand(0..3),
    introduction: ["特になし", "jbdf A級", "jbdf A級", "jbdf B級", "jbdf C級"].sample,
    status: rand(0..1),
    club_status: rand(0..3),
    is_active: true,
    email: "user#{n}@test.com",
    password: "password"
    )
end

30.times do |n|
  name = ('A'..'Z').to_a.sample + "." + ('A'..'Z').to_a.sample
  area = [8, 9, 10, 11, 12, 13, 14, 25, 26, 27, 28, 29, 30]
  User.create(
    name: name,
    age: rand(23..60),
    target: Faker::Boolean.boolean,
    height: rand(150..180),
    area: area.sample,
    experience: rand(4..6),
    introduction: ["特になし", "jbdf A級", "jbdf A級", "jbdf B級", "jbdf C級"].sample,
    status: rand(0..1),
    club_status: rand(4..5),
    is_active: true,
    email: "user#{n}@test.com",
    password: "password"
    )
end

30.times do |n|
  name = ('A'..'Z').to_a.sample + "." + ('A'..'Z').to_a.sample
  area = [1..47]
  User.create(
    name: name,
    age: rand(23..60),
    target: Faker::Boolean.boolean,
    height: rand(150..180),
    area: area.sample,
    experience: rand(4..6),
    introduction: ["特になし", "jbdf A級", "jbdf A級", "jbdf B級", "jbdf C級"].sample,
    status: rand(0..1),
    club_status: rand(4..5),
    is_active: true,
    email: "user#{n}@test.com",
    password: "password"
    )
end

User.all.each do |user|
  Post.create(
    user_id: user.id,
    min_age: rand(15..30),
    max_age: rand(30..60),
    min_height: rand(100..150),
    max_height: rand(151..200),
    status: rand(0..2),
    directionality: rand(0..5),
    experience: rand(0..5),
    place: Faker::Address.city,
    frequency: "週" + rand(1..7).to_s,
    comment: ["頑張ります", "競技会に出たいです", "気軽にDMください"].sample,
  )
end

Admin.create(email: 'admin@example.com', password: 'password')