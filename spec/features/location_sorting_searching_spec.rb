require "spec_helper"

feature "list of locations can be searched" do
let!(:first_location) {FactoryGirl.create(:location)}
let!(:second_location) do
  location = FactoryGirl.build(:location)
  location.name = "Paris"
  location.states = "Germany"
  location.save
  location
end

  scenario "user can search by name" do
    visit(locations_path)
    fill_in "Search",  with: first_location.name
    click_button "Search"
    expect(page).to have_content(first_location.name)
    expect(page).to_not have_content(second_location.name)
  end

  scenario "user can search by states" do
    visit(locations_path)
    fill_in "Search",  with: first_location.states
    click_button "Search"
    expect(page).to have_content(first_location.name)
    expect(page).to_not have_content(second_location.name)
  end

  scenario "user can search by states" do
    visit(locations_path)
    fill_in "Search",  with: first_location.states
    click_button "Search"
    expect(page).to have_content(first_location.name)
    expect(page).to_not have_content(second_location.name)
  end

end