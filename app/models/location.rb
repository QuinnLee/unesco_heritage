class Location < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  reverse_geocoded_by :latitude, :longitude,
    :address => :address
  after_validation :reverse_geocode,
     :unless => lambda{ |obj| Rails.env.test? }

  has_many :log_entries, :dependent => :destroy
  has_many :plan_entries, :dependent => :destroy
  
  has_many :plans, :through => :plan_entries
  has_many :users, :through => :log_entries

  validates :longitude,  presence: true
  validates :latitude,  presence: true
  validates :name,  presence: true

  attr_accessible :name, :longitude, :latitude, :category, :region, :states, :description,
    :image_url, :http_url

  def self.categories
    Location.uniq.pluck(:category)
  end

  def self.regions
    Location.uniq.pluck(:region)
  end

  ## Methods to create markers and info_windows for gmaps 
  def gmaps4rails_address
    "#{self.latitude},#{self.longitude}"
  end

  def gmaps4rails_marker_picture
  {
   "picture" => "/images/worldheritagesite.png",
   "width" => 60,
   "height" => 60,
   "marker_anchor" => [13, 35],
   "shadow_picture" => "/images/shadow-worldheritagesite.png" ,
   "shadow_width" => "110",
   "shadow_height" => "110",
   "shadow_anchor" => [13, 35]
  }
  end

  ## TODO find a better way to do this
  def gmaps4rails_infowindow
      "<div class='location-infobox'> <a href=/locations/#{id}>#{name}</a> <p>Type: #{category}</p> <p>Located: #{states}</p> <img src=\"#{image_url}\"> </div>"
  end
  
  def gmaps4rails_title
    name
  end

end
  
