require "spec_helper"

## User Story
## As a User, I want to delete my account

## AC
## let user delete their accounts

feature "a user can delete their account" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  scenario "redirects them to the home page with a cheerful good-bye" do
    visit(user_session_path)
    sign_in_as(valid_user)
    click_link("Edit profile")
    click_button("Cancel my account")
    expect(current_path).to eql root_path
    expect(page).to have_content("Bye! Your account was successfully cancelled. 
      We hope to see you again soon.")
  end
end
