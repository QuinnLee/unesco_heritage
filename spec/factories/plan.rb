require "faker"
FactoryGirl.define do
  factory :plan do
    name Faker::Lorem.characters 12 
  end
end
