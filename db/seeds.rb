# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "nokogiri"
require "open-uri"

url = "http://whc.unesco.org/en/list/xml/"
data = Nokogiri::XML(open(url))
rows = data.css("row")
rows.each do |row|
  Location.create(
    name: row.at_css("site").inner_text.gsub(/<\/?[^>]*>/, ""),
    longitude: row.at_css("longitude").inner_text.to_f,
    latitude: row.at_css("latitude").inner_text.to_f
    )
end