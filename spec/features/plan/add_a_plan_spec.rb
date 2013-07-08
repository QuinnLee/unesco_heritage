require "spec_helper"

## User story
## A user I want to make a plan to store locations
## I want to be able to make multiple plans

## AC
## User is able to make plans
## User is able to navigate through and out of a plan

feature "adding a plan" do

  let (:valid_user){FactoryGirl.create(:user)}

  let!(:location){FactoryGirl.create(:location)}
  
  let(:plan_name){"hello"}

  scenario "#directs user to plan#new path" do
    login_and_create_plan
    expect(page).to have_content("Plan has been made")
    expect(Plan.last.name).to eql(plan_name)
  end

  scenario "#user can navigate back to user#show" do
    login_and_create_plan
    click_link "User Page"
    expect(current_path).to eql(user_path(valid_user))
    expect(page).to have_content(Plan.last.name)
  end

  scenario "#user can navigate to the plan#show for each plan" do
    login_and_create_plan
    click_link "User Page"
    click_link(plan_name)
    plan = valid_user.plans.first
    expect(current_path).to eql(plan_path(plan))
  end

  def login_and_create_plan
    sign_in_as(valid_user)
    visit (user_path(valid_user))
    fill_in "plan_name", with: plan_name
    click_button "Create Plan"
  end
end
