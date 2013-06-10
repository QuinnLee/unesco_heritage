require "spec_helper"

describe "add log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  let!(:location) do
    FactoryGirl.create(:location)
  end

  before :each do 
    visit(user_session_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    click_button "Sign in"
  end
  
  it "a user adds a location into a log" do
    click_link ("View Locations")
    click_link("#{location.name}")
    click_button  'Add to Log'
    expect(page).to have_content("You have added #{location.name} to you log")
    expect(page).to have_content("1 Destination")
    expect(page).to have_content("#{location.name}")
  end
end