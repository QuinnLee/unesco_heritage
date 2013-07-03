require "spec_helper"

## User Story
## As a user, I want to log off

## AC
## Log off button
## redirect to home#index

#TODO FIX TEST
feature "a user logging off" do 
  let (:valid_user) do
    FactoryGirl.create(:user)
  end

  scenario "redirects user to the home page" do
    visit(new_user_session_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    click_button "Sign in"
    click_link "Logout"
    expect(current_path).to eql root_path
  end
end
