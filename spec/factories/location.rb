#Model
#Location(id: integer, name: string, created_at: datetime, updated_at: datetime)
require "faker"
FactoryGirl.define do
  factory :location do
    name Faker::Lorem.characters 12 
  end
end
