require 'spec_helper'

describe Plan do

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:plan_entries).dependent(:destroy) }
  it { should have_many(:locations).through(:plan_entries) }

  describe "#set_color" do
    let(:plan) { FactoryGirl.create(:plan) }

    it "sets a color for the plan on creation" do
      expect(plan.color).to_not be_nil
    end
  end

  describe "#users_plans" do
    let!(:plan_1) { FactoryGirl.create(:plan)  }
    let!(:plan_2) { FactoryGirl.create(:plan)  }
    let(:user) {plan_1.user}

    it "returns all plans belonging to the user" do
      plans = Plan.users_plan(user)

      expect(plans).to include(plan_1)
      expect(plans).to_not include(plan_2)
    end
  end
end
