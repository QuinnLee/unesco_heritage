require "spec_helper"

describe "a user can delete their account" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  it "redirects them to the home page with a cheerful good-bye" do
    visit(user_session_path)
    sign_in_as(valid_user)
    click_link("Edit profile")
    click_button("Cancel my account")
    expect(page).to have_content("Bye! Your account was successfully cancelled. 
      We hope to see you again soon.")
  end
  
end