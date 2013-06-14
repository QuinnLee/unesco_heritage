require "faker"
valid_password = Faker::Lorem.characters 12 
FactoryGirl.define do
  factory :user do
    sequence :email do|n|
      "person#{n}@google.com"
    end
    password valid_password
    password_confirmation valid_password
  end
end
