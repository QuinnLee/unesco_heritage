require "spec_helper"

## User Story
## As a user, I want to see the list of locations

## AC
## Let non-registered and registered users view locations#index
## Let non-registered and registered users view each location#show

feature "viewing the all the locations" do 
  before :each do
    FactoryGirl.create(:location)
  end

 let(:location){location = Location.first}

  scenario "#anyone can view the locations" do
    visit locations_path
    expect(page).to have_content("#{location.name}")
  end

  scenario "#locations can be clicked to see more info" do
    visit locations_path
    click_link "#{location.name}"
    expect(page).to have_content(location.name)
    expect(page).to have_content("Description")
    expect(current_path).to eql location_path(location)
  end

  scenario"#can return to location#index" do 
    visit locations_path
    click_link "#{location.name}"
    click_link "Locations"
    expect(current_path).to eql locations_path
  end

  context "not a registered user" do
    scenario "can return to home page"
  end

  def visit_locations_index
    visit(root_path)
    click_link("Locations")
  end

end