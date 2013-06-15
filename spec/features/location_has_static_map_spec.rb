require "spec_helper"

feature "location#show has a map", %q{
  As a user
  I want to see a map with the location on it
} do

  let!(:location) do
    FactoryGirl.create(:location)
  end

  scenario "user visits a location" do
    random_location = Location.first
    visit(locations_path)
    click_link "#{random_location.name}"
    expect(page).to have_css('img')
  end

end