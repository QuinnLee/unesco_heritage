require "spec_helper"

## User Story
## As a user, I want to see where a location is on a map

## AC
## display map of the location on its show page
feature "location static map" do

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