require "faker"
valid_password = Faker::Lorem.characters 12 
FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password valid_password
    password_confirmation valid_password
  end
end
