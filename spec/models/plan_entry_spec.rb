require 'spec_helper'

describe PlanEntry do
  it { should belong_to(:plan) }
  it { should belong_to(:location) }

  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:plan) }
  
end
