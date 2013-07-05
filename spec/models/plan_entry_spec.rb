require 'spec_helper'

describe PlanEntry do
  it { should belong_to(:plan) }
  it { should belong_to(:location) }

  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:plan) }

  describe "#plan_name" do
    let!(:plan_entry) { FactoryGirl.create(:plan_entry)  }
    let(:plan) {plan_entry.plan }
    it "returns the plan name of a plan entry" do
      name = plan_entry.plan_name
      expect(name).to eql(plan.name)
    end
  end

  describe "#location_name" do
    let!(:plan_entry) { FactoryGirl.create(:plan_entry)  }
    let(:location) {plan_entry.location }
    it "returns the plan name of a plan entry" do
      name = plan_entry.location_name
      expect(name).to eql(location.name)
    end
  end
  
end
