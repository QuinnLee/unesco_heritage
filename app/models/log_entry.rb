class LogEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validates :location, presence: true
  validates :user, presence: true

  attr_accessible :location, :user, :first_date, :last_date
end
