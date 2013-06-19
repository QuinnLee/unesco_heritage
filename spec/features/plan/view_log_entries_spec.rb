require "spec_helper"

describe "view log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  
  it "a user can view all the log entries on user#show" do
    sign_in_as(valid_user)
    expect(page).to have_content("0 Destinations")
  end
end