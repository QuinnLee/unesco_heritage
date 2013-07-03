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


end
