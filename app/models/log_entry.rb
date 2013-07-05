class LogEntry < ActiveRecord::Base
  include ActiveModel::Validations

  acts_as_gmappable :process_geocoding => false

  belongs_to :user
  belongs_to :location

  validates :location, presence: true 
  validates :user, presence: true
  validates :first_date, presence: true
  validates :last_date, presence: true

  validates_with DateRangeValidator, :uniqueness => { :scope => :user_id }

  attr_accessible :location, :user, :first_date, :last_date

  delegate :name, :longitude, :latitude, :category, :region, :states, :description,
    :image_url, :http_url, :to => :location


  def set_first_date(first_date)
    self[:first_date] = Chronic.parse(first_date).to_date
  end

  def set_last_date(last_date)
    self[:last_date] = Chronic.parse(last_date).to_date
  end

  ## Methods for Gmaps to generate markers and polylines
  def poly_line
    Hash['lng', longitude , 'lat', latitude, "strokeColor", "#00000", "strokeWeight", 3]
  end

  def gmaps4rails_marker_picture
  {
   "picture" => image_url,
   "width" => 40,
   "height" => 40,
   "marker_anchor" => [13, 35]
  }
  end

  ## TODO find a better way to do this
  def gmaps4rails_infowindow
    "<div class='location-infobox'> <a href=/locations/#{location.id}>#{name}</a> <p>Date visited: #{first_date.to_s}</p> <p>Located: #{states}</p> </div>"
  end
  
  def gmaps4rails_title
    self.name
  end

  # Date ranges cannot overlap for each user
  class << self
    def overlaps(first_date, last_date, user_id)
      where "(first_date,last_date) OVERLAPS (?,?) AND user_id = ?", first_date, last_date, user_id
    end
  end

end
