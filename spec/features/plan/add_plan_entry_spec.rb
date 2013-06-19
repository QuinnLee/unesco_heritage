require "spec_helper"

feature "add a plan entry to a plan" do
  let! (:valid_user) {FactoryGirl.create(:user)}
  let!(:valid_location) {FactoryGirl.create(:location)}
  let(:plan_name){"hello"}

  scenario "#plan entries can be added to in the location index" do
    login_and_create_plan
    add_plan_entry
    expect(page).to have_content("#{valid_location.name} was added to #{plan_name}")
  end

  scenario "#plan entries will be displayed in the plan#show" do
    login_and_create_plan
    add_plan_entry
    click_link (valid_location.name)
    expect(page).to have_content("This location is in 1 plan")
    expect(page).to have_content(plan_name)
  end

  scenario "user can add desire date a plan entry" do
    login_and_create_plan
    add_plan_entry
    select  "2010", from: "plan_entry_date_1i"
    select  "June", from: "plan_entry_date_2i"
    select  "13", from: "plan_entry_date_3i"
    click_button "Set Date"
    expect(page).to have_content('2010-06-13')
  end

  def login_and_create_plan
    sign_in_as(valid_user)
    click_link "User Page"
    fill_in "Name", with: plan_name
    click_button "Create Plan"
  end

  def add_plan_entry
    click_link "Locations"
    click_link  valid_location.name
    select("#{plan_name}", :from => "plan[id]")
    click_button "Add to Plan"
  end

end
