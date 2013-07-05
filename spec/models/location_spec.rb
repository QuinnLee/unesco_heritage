require 'spec_helper'

describe Location do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:latitude) }

  it { should have_many(:log_entries).dependent(:destroy) }
  it { should have_many(:plan_entries).dependent(:destroy) }

  it { should have_many(:plans).through(:plan_entries)}
  it { should have_many(:users).through(:log_entries)}

  describe "#self.categories" do
    let!(:location_1) {FactoryGirl.create(:location)  }
    it "returns a list of categories of the locations" do
      categories = Location.categories
      expect(categories).to be_an_instance_of(Array)
      expect(categories).to include(location_1.category)
    end
  end

  describe "#self.regions" do
    let!(:location_1) {FactoryGirl.create(:location)  }
    it "returns a list of categories of the locations" do
      regions = Location.regions
      expect(regions).to be_an_instance_of(Array)
      expect(regions).to include(location_1.region)
    end
  end

end
