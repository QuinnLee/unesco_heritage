require 'spec_helper'

describe Plan do
  it { should validate_presence_of(:user) }
  it { should validate_uniquness_of(:name) }
end
