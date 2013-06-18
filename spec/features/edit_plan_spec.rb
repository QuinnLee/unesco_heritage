require "spec_helper"

feature "A user can edit a plan" do
  
 let (:valid_user) do
    FactoryGirl.create(:user)
  end
  
  let(:plan_name){"hello"}

  scenario "user wants to edit plan" do
    login_and_create_plan
    fill_in "Name", with: "Not Hello"
    click_button "Change name"
    expect(page).to have_content ("Plan's name changed to Not Hello")
  end

  def login_and_create_plan
    sign_in_as(valid_user)
    fill_in "Name", with: plan_name
    click_button "Create Plan"
  end
end