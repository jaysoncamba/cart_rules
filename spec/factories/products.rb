FactoryBot.define do
  factory :product do
    sequence(:code) { |n| "P#{n}#{FFaker::Lorem.characters(2).upcase}" }
    name { FFaker::Product.product_name }
    price { rand(1.0..20.0).round(2) }
  end
end
