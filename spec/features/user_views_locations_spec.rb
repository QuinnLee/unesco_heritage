require "spec_helper"

describe "location view" do
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

  it "a user can go visit the locations index and each location" do
    random_location = Location.first
    click_link("View Locations")
    click_link "#{random_location.name}"
    expect(page).to have_content(random_location.name)
    expect(page).to have_content("Description")
  end
end