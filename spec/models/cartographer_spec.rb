require "spec_helper"

describe Cartographer do

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

  describe "#locations_near_user" do
    let!(:user){FactoryGirl.create(:user)}

    it "returns locations around 1000km around the user" do
    
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

      expect(results[0]).to eql log_entry_2
      expect(results[1]).to eql log_entry_1
    end
  end



end
