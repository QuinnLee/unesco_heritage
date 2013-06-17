class Location < ActiveRecord::Base
  has_many :log_entries
  has_many :plan_entries
  
  has_many :plans, :through => :plan_entries
  has_many :users, :through => :log_entries

  validates :longitude,  presence: true
  validates :latitude,  presence: true
  validates :name,  presence: true

  attr_accessible :name, :longitude, :latitude, :category, :region, :states

  def static_image
    "#{self.latitude},#{self.longitude}"
  end

  def self.categories
    Location.uniq.pluck(:category)
  end

  def self.regions
    Location.uniq.pluck(:region)
  end
end
