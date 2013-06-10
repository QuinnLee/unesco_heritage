require "spec_helper"

describe "view log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end

  before :each do 
    visit(user_session_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    click_button "Sign in"
  end
  
  it "a user can view all the log entries on user#show" do
    expect(page).to have_content("0 Destinations")
  end
end