require 'spec_helper'

describe Location do
  describe "#log_entries_for(user)" do
    let (:valid_user){FactoryGirl.create(:user)}
    let!(:location){FactoryGirl.create(:location)}
    
    it "returns all log entries scoped to user" do
      
    end
  end
end