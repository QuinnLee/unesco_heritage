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
    :image_url, :http_url, to: :location

  def poly_line
    Hash['lng', self.longitude , 'lat', self.latitude, "strokeColor", "#00000", "strokeWeight", 3]
  end

  def gmaps4rails_marker_picture
  {
   "picture" => self.image_url,
   "width" => 60,
   "height" => 60,
   "marker_anchor" => [30, 30]
  }
  end

  def gmaps4rails_infowindow
      "<img src=\"#{self.image_url}\"> #{self.name}, <br> Date visited: #{first_date} to #{last_date}"
  end
  
  def gmaps4rails_title
    self.name
  end

  def set_first_date(first_date)
    self[:first_date] = Chronic.parse(first_date).to_date
  end

  def set_last_date(last_date)
    self[:last_date] = Chronic.parse(last_date).to_date
  end

  class << self
    def overlaps(first_date, last_date, user_id)
      where "(first_date,last_date) OVERLAPS (?,?) AND user_id = ?", first_date, last_date, user_id
    end
  end

end
