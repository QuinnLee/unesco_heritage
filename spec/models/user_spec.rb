require 'spec_helper'


describe User do

  let (:valid_user) do
    FactoryGirl.build(:user)
  end

  it "allows a valid user" do
    expect(valid_user).to be_valid
  end

h

  it { should validate_uniqueness_of(:email) }

  it { should have_many(:plans) }
  it { should have_many(:locations).through(:log_entries) }
end
