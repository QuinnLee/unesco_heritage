require "spec_helper"
## User Story 
## As a user, I want know my current location

## AC
## save coordinate data on user

feature "geolocate user", :vcr do
  let!(:user) { FactoryGirl.create(:user) }

  scenario "#user logs in" do
    user = User.first
    user.current_sign_in_ip = "127.0.0.0.1"
    user.geocode
    expect(user.longitude).to_not be_nil
    expect(user.latitude).to_not be_nil
  end

  scenario "#user's ip changes" do 
    user = User.first
    user.current_sign_in_ip = "127.0.0.0.1"
    user.geocode

    long = user.longitude
    lat = user.latitude

    user.current_sign_in_ip = "216.15.125.0" 
    user.geocode
    expect(user.longitude).to_not eql(long)
    expect(user.latitude).to_not eql(lat)
  end
end
