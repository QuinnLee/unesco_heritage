require "spec_helper"

## Acceptance Criteria 
## as a user, I want to log into the site and be at the user page

describe "a user can log in the site" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  it "redirects them to the home page" do
    visit(user_session_path)
    sign_in_as(valid_user)
    expect(page).to have_content("Signed in successfully.")
  end
end