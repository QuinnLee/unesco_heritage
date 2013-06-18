require "spec_helper"

## A
describe "a user logging off" do 
  let (:valid_user) do
    FactoryGirl.create(:user)
  end

  it "redirects user to the home page" do
    visit(new_user_session_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    click_button "Sign in"
    click_link "Logout"
    expect(page).to have_content("Signed out successfully.")
  end
end