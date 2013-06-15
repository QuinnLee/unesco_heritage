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
    add_a_log_entry(location)
    click_link("#{location.name}")
    click_button 'Remove from Log'
    expect(page).to have_content("0 Destinations")
  end
end