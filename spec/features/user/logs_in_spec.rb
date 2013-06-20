require "spec_helper"

## User Story 
## As a user, I want to log into the site and be at the user page

## AC
## When user successfully signs in, redirected to location#index
## Else redirect to home#index

feature "a user can log in the site" do
  let(:valid_user) {FactoryGirl.create(:user)}

  let(:invalid_user){FactoryGirl.build(:user)}
  scenario "#redirects them to the home page" do
    visit(user_session_path)
    sign_in_as(valid_user)
    expect(page).to have_content("Signed in successfully.")
    expect(current_path).to eql locations_path
  end

  scenario "#redirects them to the home page" do
    visit(user_session_path)
    sign_in_as(invalid_user)
    expect(page).to have_content("Invalid email or password")
  end
end
