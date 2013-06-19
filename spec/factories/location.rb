#Location(id: integer, name: string, created_at: datetime, updated_at: datetime, latitude: float, longitude: float, 
#         category: string, region: string, states: string)
require "faker"
FactoryGirl.define do
  factory :location do

    sequence :name do 
      Faker::Lorem.characters 12
    end 
    longitude (100.1)
    latitude (100.11)
    sequence :category do 
      Faker::Lorem.characters 3
    end
     sequence :region do 
      Faker::Lorem.characters 5
    end
    states "France"
  end
end
