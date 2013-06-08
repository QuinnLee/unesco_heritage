require "spec_helper"

describe "locations#index" do 
  before :each do
    FactoryGirl.create(:location)
  end

  it "shows all locations" do
    random_location = Location.first
    visit(locations_path)
    expect(page).to have_content("#{random_location.name}")
  end

  it "locations can be clicked to see more info" do
    random_location = Location.first
    visit(locations_path)
    click_link "#{random_location.name}"
    expect(page).to have_content(random_location.name)
    expect(page).to have_content("Description")
  end

end