require 'spec_helper'

describe LogEntry do

  it { should belong_to(:user)}
  it { should belong_to(:location)}

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:first_date) }
  it { should validate_presence_of(:last_date) }

  describe "#validates_range" do
    let(:user){FactoryGirl.create(:user)}
    let(:user_2){FactoryGirl.create(:user)}
    let!(:log_entry){FactoryGirl.create(:log_entry,user: user)}
    let!(:log_entry2){FactoryGirl.build(:log_entry, user: user)}

    let!(:log_entry_valid_diff_user){FactoryGirl.build(:log_entry, user: user_2)}
    it "doesn't set dates if invalid" do
      expect(log_entry2).to_not be_valid
    end

    it "sets dates if valid" do
      expect(log_entry_valid_diff_user).to be_valid
    end

  end

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
