require "spec_helper"

describe "user sign up" do
  it "creates a new account when all correct info is inputted" do
    email = "jzigt@aol.com"
    password = "wootasdasd"
    visit(new_user_registration_path)
    expect(page).to have_content("Sign up")
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    expect(User.last.email).to eql(email)
  end
  it "rejects a account if incorrect info is inputed"
end