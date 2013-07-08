require "spec_helper"

describe Cartographer, :vcr do

  describe "#user_log_entries" do
    let!(:log_entry) { FactoryGirl.create(:log_entry) }
    let!(:other_log_entry) { FactoryGirl.create(:log_entry) }
    let(:user) { log_entry.user }
    let(:location) { log_entry.location }

    it "returns log entries for user for location" do
      results = Cartographer.new(user: user, location: location).user_log_entries
      expect(results).to include log_entry
      expect(results).not_to include other_log_entry
    end
  end
  
  describe "#locations_near_user" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:location_1) do
      location_1 = FactoryGirl.create(:location)
      location_1.longitude =  24
      location_1.latitude = 44
      location_1.save!
      location_1
    end
    it "returns locations around 1000km around the user" do
      user.current_sign_in_ip = "127.0.0.0.1"
      user.geocode
      results = Cartographer.new(user: user)
      expect(results.locations_near_user).to include location_1
    end
  end

  describe "#users_plan_entries" do
    let!(:plan_entry) { FactoryGirl.create(:plan_entry) }
    let!(:other_plan_entry) { FactoryGirl.create(:plan_entry) }
    let(:plan ){plan_entry.plan}
    let(:user) { plan.user }
    let(:location) { plan_entry.location }

    it "returns log entries for user for location" do
      results = Cartographer.new(user: user, location: location).users_plan_entries
      expect(results).to include plan_entry
      expect(results).not_to include other_plan_entry
    end
  end

  describe "#markers" do
    let(:user) { FactoryGirl.create(:user)  }
    let(:location) {FactoryGirl.create(:location)}

    it "returns markers if a user is passed" do
      user.current_sign_in_ip = "127.0.0.0.1"
      user.geocode
      results =Cartographer.new(user: user)
      expect(results.markers).to_not be_nil
      expect(results.markers).to_not eql('[]') 
    end

    it "returns markers if a location is passed" do
      results =Cartographer.new(location: location)
      expect(results.markers).to_not be_nil
      expect(results.markers).to_not eql('[]')
    end

    it "returns [] if nothing is passed" do
      results =Cartographer.new()
      expect(results.markers).to_not be_nil
      expect(results.markers).to eql('[]')
    end

  end

  describe "#polylines" do
    let(:user) { FactoryGirl.create(:user)  }

    it "returns polylines if a user is passed" do
      user.current_sign_in_ip = "127.0.0.0.1"
      user.geocode
      results =Cartographer.new(user: user)
      expect(results.polylines).to_not be_nil
      expect(results.markers).to_not eql('[]') 
    end

    it "returns [] if a user isn't passed " do
      results =Cartographer.new()
      expect(results.markers).to_not be_nil
      expect(results.markers).to eql('[]')
    end

  end

  describe "#sorted_log_entries" do
    let!(:log_entry_1) { FactoryGirl.create(:log_entry) }
    let(:date) { Time.now.to_date }
    let!(:log_entry_2) { FactoryGirl.create(:log_entry, user: log_entry_1.user,
      first_date: date, last_date: date) }
    let(:user ){log_entry_1.user}
    let(:location ){log_entry_1.location}
    
    it "returns sorted log entry for user descending order" do
      results = Cartographer.new(user: user, location: location).sorted_log_entries

      expect(results[0]).to eql log_entry_1
      expect(results[1]).to eql log_entry_2
    end
  end



end
