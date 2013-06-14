class LogEntry < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :user
  belongs_to :location

  validates :location, presence: true
  validates :user, presence: true
  validates :first_date, presence: true
  validates :last_date, presence: true

  validates_with DateRangeValidator

  attr_accessible :location, :user, :first_date, :last_date

  def set_first_date(first_date)
    self[:first_date] = Chronic.parse(first_date).to_date
  end

  def set_last_date(last_date)
    self[:last_date] = Chronic.parse(last_date).to_date
  end

  class << self
    def overlaps(first_date, last_date)
      where "(first_date,last_date) OVERLAPS (?,?)", first_date, last_date
    end
  end

end
