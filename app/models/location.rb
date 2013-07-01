class Location < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, :if => lambda{ |obj| obj.address_changed? }
  
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

  def gmaps4rails_marker_picture
  {
   "picture" => "/images/worldheritagesite.png",
   "width" => 60,
   "height" => 60,
   "marker_anchor" => [5, 10],
   "shadow_picture" => "/images/shadow-worldheritagesite.png" ,
   "shadow_width" => "110",
   "shadow_height" => "110",
   "shadow_anchor" => [5, 10]
  }
  end

  def gmaps4rails_infowindow
      "<img src=\"#{self.image_url}\"> <br> #{self.name}"
  end
  
  def gmaps4rails_title
    self.name
  end

end
  
