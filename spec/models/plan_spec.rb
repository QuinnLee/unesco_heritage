require 'spec_helper'

describe Plan do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:plan_entries) }
  it { should have_many(:locations).through(:plan_entries) }
end
