#Location(id: integer, name: string, created_at: datetime, updated_at: datetime, latitude: float, longitude: float, 
#         category: string, region: string, states: string)
require "faker"
FactoryGirl.define do
  factory :location do
    name Faker::Lorem.characters 12 
    longitude (100.1)
    latitude (100.11)
    category "Cultural"
    region "Africa"
    states "France"
    description Faker::Lorem.characters 12 
    http_url "http://whc.unesco.org/en/list/1363"
    image_url "http://whc.unesco.org/uploads/sites/site_1363.jpg"
  end
end
