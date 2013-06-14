require 'spec_helper'

describe LogEntry do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:first_date) }
  it { should validate_presence_of(:last_date) }
  
  describe "#set_first_date" do
    it "converts string to a date" do
      log_entry = LogEntry.new
      valid_date = Date.parse('1999-11-11')

      log_entry.set_first_date("11/11/99")

      expect(log_entry.first_date).to eql(valid_date)
    end
  end

  describe "#set_last_date" do
    it "converts string to a date" do
      log_entry = LogEntry.new
      valid_date = Date.parse('1999-11-11')

      log_entry.set_last_date("11/11/99")

      expect(log_entry.last_date).to eql(valid_date)
    end
  end

end   
