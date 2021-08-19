FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    target { Faker::Boolean.boolean }
    age { 20 }
    height { 170 }
    area { 1 }
    experience { 0 }
    introduction { Faker::Lorem.characters(number: 20) }
    status { 0 }
    club_status { 0 }
    is_active { Faker::Boolean.boolean }
    password { 'password' }
    password_confirmation { 'password' }
  end
end