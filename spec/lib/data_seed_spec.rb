require 'spec_helper'
##FINISH THIS
describe Seeder::Locations, :vcr do
  let(:url){"http://whc.unesco.org/en/list/xml/"}
  let(:seeder){Seeder::Locations}
  
  it "seeds the location table" do
    origin_count = Location.count
    seeder.seed_from(url)
    expect(Location.count).to_not be_eql (origin_count)
  end

  describe "#get_description" do
    it "gets a description from the row" do
      data = Nokogiri::XML(open(url))
      data.encoding = 'UTF-8'

      rows = data.css("row")

      rows.each do |row|
        expect(Seeder::Locations.get_description(row)).to_not be_nil
      end
    end
  end

end
