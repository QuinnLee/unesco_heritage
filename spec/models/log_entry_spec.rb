require 'spec_helper'

describe LogEntry do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:location) }
end   
