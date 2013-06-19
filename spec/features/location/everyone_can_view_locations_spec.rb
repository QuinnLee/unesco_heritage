require "spec_helper"

feature "viewing the all the locations" do 
  before :each do
    FactoryGirl.create(:location)
  end

 let(:location){location = Location.first}

  scenario "anyone can view the locations" do
    visit(locations_path)
    expect(page).to have_content("#{location.name}")
  end

  scenario "locations can be clicked to see more info" do
    visit(locations_path)
    click_link "#{location.name}"
    expect(page).to have_content(location.name)
    expect(page).to have_content("Description")
  end

end