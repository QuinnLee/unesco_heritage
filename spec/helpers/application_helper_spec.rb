require "spec_helper"

describe ApplicationHelper do
  let(:user) { FactoryGirl.create(:user) }

  it "returns a url for an image" do 
    url = avatar_url(user)
    expect(url).to_not be_nil
  end
end
