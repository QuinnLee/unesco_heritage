require 'spec_helper'

describe Location do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:latitude) }

  

end
