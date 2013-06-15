require "spec_helper"

feature "adding a plan" do

  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  let(:plan_name){"hello"}

  scenario "directs user to plan#new path" do
    login_and_create_plan
    expect(page).to have_content("Plan has been made")
    expect(Plan.last.name).to eql(plan_name)
  end

  scenario "user can navigate back to user#show" do
    login_and_create_plan
    click_link "Return User Page"

    expect(page).to have_content("user#show")
    expect(page).to have_content(Plan.last.name)
  end

  scenario "user can navigate to the plan#show for each plan" do
    login_and_create_plan
    click_link "Return User Page"

    click_link(plan_name)

    expect(page).to have_content("plan#show")
  end

  def login_and_create_plan
    sign_in_as(valid_user)
    fill_in "Name", with: plan_name
    click_button "Create Plan"
  end
end
