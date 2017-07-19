FactoryGirl.define do
  factory :insurance do
    tobacco_product Faker::Boolean.boolean
    health_condition Faker::Boolean.boolean
    gender ["male", "female"].sample
    birthday Date.parse("1989-05-19")
    height 169
    weight 15
    coverage_amount Faker::Number.number(8)
    payment_frequency ["annual", "semi-annual", "quarterly", "monthly"].sample
    terms_and_services Faker::Boolean.boolean
  end
end
