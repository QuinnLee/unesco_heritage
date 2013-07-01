require "spec_helper"

feature "remove a log" do
  let (:valid_user){ FactoryGirl.create(:user)}
  let!(:location){ FactoryGirl.create(:location)}
  
  scenario "a user clicks a button to remove the log entry" do
    sign_in_as(valid_user)
    add_a_log_entry(location)
    click_link("#{location.name}")
    click_button 'Remove'
    expect(page).to have_content("You have been to no destinations")
    expect(current_path).to eql user_path(valid_user)
  end
end
