class Location < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
  has_many :log_entries
  has_many :plan_entries
  
  has_many :plans, :through => :plan_entries
  has_many :users, :through => :log_entries

  validates :longitude,  presence: true
  validates :latitude,  presence: true
  validates :name,  presence: true

  attr_accessible :name, :longitude, :latitude, :category, :region, :states, :description,
    :image_url, :http_url

  def gmaps4rails_address
    "#{self.latitude},#{self.longitude}"
  end

  def self.categories
    Location.uniq.pluck(:category)
  end

  def self.regions
    Location.uniq.pluck(:region)
  end
  
end
