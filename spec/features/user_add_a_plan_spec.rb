require "spec_helper"

describe "adding a plan" do
  let (:plan) do
    FactoryGirl.create(:plan)
  end
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  it "directs user to plan#new path" do
    sign_in_as(valid_user)
    fill_in "Name", with: plan.name
    click_button "Create Plan"
        save_and_open_page
    expect(page).to have_content("Plan has been made")
    expect(page).to have_content("#{plan.name}")
  end
end