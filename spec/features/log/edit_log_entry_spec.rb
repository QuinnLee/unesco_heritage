require "spec_helper"

feature "edit log" do
  let(:valid_user) { FactoryGirl.create(:user)}
  let(:location) { FactoryGirl.create(:location)}
  
  
  scenario "redirect user back to user#show" do
    sign_in_as(valid_user)
    add_a_log_entry(location)

    new_log_entry = LogEntry.last
    expect(page).to have_content("#{Chronic.parse(new_log_entry.last_date).to_date}")
  end
end

