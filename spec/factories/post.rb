FactoryBot.define do
  factory :post do
    min_age { 20 }
    max_age { 35 }
    min_height { 150 }
    max_height { 170 }
    status { 0 }
    directionality { 0 }
    experience { 0 }
    place { Faker::Address.city }
    frequency { "週3" }
    comment { "頑張ります" }
    user
  end
end