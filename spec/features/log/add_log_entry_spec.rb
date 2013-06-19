require "spec_helper"

feature "add log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  let(:location) do
    FactoryGirl.create(:location)
  end
  
  scenario "redirect user back to user#show" do
    sign_in_as(valid_user)
    add_a_log_entry(location)
    new_log_entry = LogEntry.last
    expect(page).to have_content("You have added #{new_log_entry.location.name} to you log")
    expect(page).to have_content("1 Destination")
    expect(page).to have_content("#{new_log_entry.location.name}")
    expect(page).to have_content("#{Chronic.parse(new_log_entry.last_date).to_date}")
  end
end
