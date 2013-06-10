class LogEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  attr_accessible :location_id, :user_id, :first_date, :last_date
end
