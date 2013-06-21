require "spec_helper"

describe "a user can navigate to and from the locations index" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  before :each do
    FactoryGirl.create(:location)
    visit(user_session_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    click_button "Sign in"
  end

  it "the user can navigate" do
    random_location = Location.first
    visit(locations_path)
    click_link "#{random_location.name}"
    click_link "Locations"
    click_link "User Page"
    expect(current_path).to eql(user_path(valid_user))
  end
end
