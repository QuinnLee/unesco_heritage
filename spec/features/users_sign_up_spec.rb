require "spec_helper"

describe "user sign up" do
  let (:valid_user) do
    FactoryGirl.build(:user)
  end
  it "creates a new account when all correct info is inputted" do
    visit(new_user_registration_path)
    expect(page).to have_content("Sign up")
    fill_in "Email", with: valid_user.email
    fill_in "Password", with: valid_user.password
    fill_in "Password confirmation", with: valid_user.password_confirmation
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    expect(User.last.email).to eql(valid_user.email)
  end
end