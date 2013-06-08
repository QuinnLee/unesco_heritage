require "spec_helper"
describe "a non-user navigation path" do
  before :each do
    FactoryGirl.create(:location)
  end
  it "non-user can navigate to each location and back to the home pages" do
    random_location = Location.first
    visit(root_path)
    click_link "Locations"
    click_link "#{random_location.name}"
    click_link "Return to Locations"
    click_link "Home"
    expect(page).to have_content("home#index")
  end
end