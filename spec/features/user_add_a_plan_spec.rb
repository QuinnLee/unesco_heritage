require "spec_helper"

describe "adding a plan" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end

  it "directs user to plan#new path" do
    plan_name = "hello"
    sign_in_as(valid_user)
    fill_in "Name", with: plan_name
    click_button "Create Plan"
    expect(page).to have_content("Plan has been made")
    expect(page).to have_content(plan_name)
  end
end