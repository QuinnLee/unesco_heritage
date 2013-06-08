require 'spec_helper'


describe User do
  let (:valid_user) do
    FactoryGirl.build(:user)
  end
 it "allows a valid user" do
  expect(valid_user).to be_valid
 end
 it "doesn't allow if passwords aren't confirmed"
 it "doesn't allow if the email isn't valid"

end
