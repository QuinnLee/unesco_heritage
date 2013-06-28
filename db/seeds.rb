# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "nokogiri"
require "open-uri"
#TODO REFACTOR THIS
url = "http://whc.unesco.org/en/list/xml/"
data = Nokogiri::XML(open(url))
data.encoding = 'UTF-8'
rows = data.css("row")

def get_description(row)
  long_desription = row.at_css("long_description").inner_text
  if long_desription.empty?
    row.at_css("short_description").inner_text
  else
    long_desription
  end
end

rows.each do |row|
  Location.create(
    name: row.at_css("site").inner_text.gsub(/<\/?[^>]*>/, ""),
    longitude: row.at_css("longitude").inner_text.to_f,
    latitude: row.at_css("latitude").inner_text.to_f,
    category: row.at_css("category").inner_text.to_s,
    region: row.at_css("region").inner_text.to_s,
    states: row.at_css("states").inner_text.to_s,
    description: get_description(row),
    http_url: row.at_css("http_url").inner_text.to_s,
    image_url: row.at_css("image_url").inner_text.to_s
    )
end
