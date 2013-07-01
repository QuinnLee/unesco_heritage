require "spec_helper"

## User Story
## As a User, I want to delete my account

## AC
## let user delete their accounts

## TODO FIX
feature "a user can delete their account" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  
  scenario "redirects them to the home page with a cheerful good-bye" do
    visit(user_session_path)
    sign_in_as(valid_user)
    visit(edit_user_registration_path)
    click_button("Cancel my account")
    expect(current_path).to eql root_path
    expect(User.count).to eql 0
  end
end
