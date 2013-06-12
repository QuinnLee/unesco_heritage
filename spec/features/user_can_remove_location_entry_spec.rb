require "spec_helper"

describe "add log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  let!(:location) do
    FactoryGirl.create(:location)
  end
  
  it "a user adds a location into a log" do
    sign_in_as(valid_user)
    click_link ("View Locations")
    click_link("#{location.name}")
    fill_in "First date", with: Date.current.to_s
    fill_in "Last date", with: Date.tomorrow.to_s
    click_button  'Add to Log'
    click_link("#{location.name}")
    click_button 'Remove from Log'
    expect(page).to have_content("0 Destinations")
  end
end