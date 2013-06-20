require "spec_helper"
## As a user
## I want to add a location to my travel log

## AC
## A button on a location#show to add the location to the log
## Date form for the dates

feature "add log" do
  let(:valid_user) { FactoryGirl.create(:user)}
  let(:location) { FactoryGirl.create(:location)}
  
  scenario "redirect user back to user#show" do
    sign_in_as(valid_user)
    add_a_log_entry(location)
    new_log_entry = LogEntry.last
    expect(page).to have_content("You have added #{new_log_entry.location.name} to you log")
    expect(page).to have_content("1 Destination")
    expect(page).to have_content("#{new_log_entry.location.name}")
    expect(page).to have_content("#{Chronic.parse(new_log_entry.last_date).to_date}")
  end

  scenario "raise error flash if the it is invalid log" do
    sign_in_as(valid_user)
    add_a_log_entry(location)
    add_a_log_entry(location)
    expect(current_path).to eql location_path(location)
    expect(page).to have_content("This entry is invalid")
  end
end
