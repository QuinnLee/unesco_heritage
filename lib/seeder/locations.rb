require "nokogiri"
require "open-uri"

module Seeder
  module Locations

    def self.seed_from(url)
      data = Nokogiri::XML(open(url))
      data.encoding = 'UTF-8'
      rows = data.css("row")

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
    end

    def self.get_description(row)
      long_desription = row.at_css("long_description").inner_text
      if long_desription.empty?
        row.at_css("short_description").inner_text
      else
        long_desription
      end
    end

  end
end
