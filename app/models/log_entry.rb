class LogEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  validates :location, presence: true
  validates :user, presence: true
  validates :first_date, presence: true
  validates :last_date, presence: true

  attr_accessible :location, :user, :first_date, :last_date

  def set_first_date(first_date)
    self[:first_date] = Chronic.parse(first_date).to_date
  end

  def set_last_date(last_date)
    self[:last_date] = Chronic.parse(last_date).to_date
  end

end
