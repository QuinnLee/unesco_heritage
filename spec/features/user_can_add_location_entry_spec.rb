require "spec_helper"

describe "add log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  let!(:location) do
    FactoryGirl.create(:location)
  end
  
  it "redirect user back to user#show" do
    sign_in_as(valid_user)
    click_link ("View Locations")
    click_link("#{location.name}")
    fill_in "First date", with: Date.current.to_s
    fill_in "Last date", with: Date.tomorrow.to_s
    click_button  'Add to Log'
    expect(page).to have_content("You have added #{location.name} to you log")
    expect(page).to have_content("1 Destination")
    expect(page).to have_content("#{location.name}")
    expect(page).to have_content(Date.current.to_s)
  end
end