require "spec_helper"

describe "add log" do
  let (:valid_user) do
    FactoryGirl.create(:user)
  end
  let!(:location) do
    FactoryGirl.create(:location)
  end
  
  it "redirect user back to user#show" do
    sign_in_as(valid_user)
    add_a_log_entry(location)
    expect(page).to have_content("You have added #{location.name} to you log")
    expect(page).to have_content("1 Destination")
    expect(page).to have_content("#{location.name}")
    expect(page).to have_content("#{Chronic.parse('12/12/88').to_date}")
  end
end