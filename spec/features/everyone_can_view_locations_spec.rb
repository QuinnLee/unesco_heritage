require "spec_helper"

describe "locations#index" do 
  before :each do
    FactoryGirl.create(:location)
  end

 let(:location){location = Location.first}

  it "shows all locations" do
    visit(locations_path)
    expect(page).to have_content("#{location.name}")
  end

  it "locations can be clicked to see more info" do
    visit(locations_path)
    click_link "#{location.name}"
    expect(page).to have_content(location.name)
    expect(page).to have_content("Description")
  end

end