require "spec_helper"
## User Story
## as a user, I want to sign up for the site

## AC
## Have a form to sign up
## If successful, redirect to locations#show
## else back to home page

feature "user sign up" do
  let(:valid_user) do
    FactoryGirl.build(:user)
  end

  scenario "#creates a new account when all correct info is inputted" do
    visit(root_path)
    within("#sign_up") do
      fill_in "Email", with: valid_user.email
      fill_in "Password", with: valid_user.password
      fill_in "Password confirmation", with: valid_user.password_confirmation
    end

    click_button "Sign up"
    
    expect(page).to have_content("You have signed up successfully.")
    expect(User.last.email).to eql(valid_user.email)
    expect(current_path).to eql locations_path
  end

  scenario "#redirects back to home page if user's password don't match" do
    visit(root_path)
    within("#sign_up") do
      fill_in "Email", with: valid_user.email
      fill_in "Password", with: valid_user.password
      fill_in "Password confirmation", with: " "
    end
    click_button "Sign up"
    save_and_open_page
    expect(page).to have_content("Password doesn't match confirmation")
    expect(User.count).to eql(0)
  end
end