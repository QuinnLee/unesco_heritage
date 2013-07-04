require "spec_helper"
## User Story
## as a user, I want to sign up for the site

## AC
## Have a form to sign up
## If successful, redirect to locations#show
## else back to home page

#TODO
feature "user sign up" do
  let(:valid_user) {FactoryGirl.build(:user)}

  scenario "#creates a new account when all correct info is inputted" do
    visit(new_user_registration_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    fill_in "Password confirmation", with: valid_user.password_confirmation
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    expect(User.last.email).to eql(valid_user.email)
    expect(current_path).to eql locations_path
  end

  scenario "#redirects back to home page if user's password don't match" do
    current_user_count = User.count
    visit(new_user_registration_path)
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    fill_in "Password confirmation", with: " "
    click_button "Sign up"
    expect(page).to have_content("Please review the problems below")
    expect(User.count).to eql(current_user_count)
  end
end
