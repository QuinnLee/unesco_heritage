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
    date = "2010-06-13"
    fill_in "Date", with: date
    click_button "Set Date"
    plan=PlanEntry.first
    expect(plan.date.to_s).to eql(date)
    expect(page).to have_content(date)
  end

  def login_and_create_plan
    sign_in_as(valid_user)
    click_link "User Page"
    fill_in "Name", with: plan_name
    click_button "Create Plan"
  end

  def add_plan_entry
    click_link "Explorer"
    click_link  valid_location.name
    select("#{plan_name}", :from => "plan_entry_plan_id")
    click_button "Add to Plan"
  end

end
