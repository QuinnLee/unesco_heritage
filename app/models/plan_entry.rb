class PlanEntry < ActiveRecord::Base
  belongs_to :plan
  belongs_to :location

  acts_as_gmappable :process_geocoding => false
  
  validates :location, presence: true
  validates :plan, presence: true
  
  attr_accessible :location, :plan_id, :date

  delegate :name, :longitude, :latitude, :category, :region, :states, :description,
    :image_url, :http_url, to: :location

  def poly_line
    Hash['lng', self.longitude , 'lat', self.latitude, "strokeColor", self.plan.color, "strokeWeight", 3]
  end

  def gmaps4rails_marker_picture
  {
   "picture" => "/images/summercamp.png",
   "width" => 30,
   "height" => 30,
   "marker_anchor" => [5, 10],
   "shadow_picture" => "/images/shadow-worldheritagesite.png",
   "shadow_width" => "110",
   "shadow_height" => "110",
   "shadow_anchor" => [10, 10]
  }
  end

  def gmaps4rails_infowindow
      "<img src=\"#{self.image_url}\">  <br> #{self.name} <br> Date planed: #{date} <br> Plan:#{self.plan_name}"
  end
  
  def gmaps4rails_title
    self.name
  end


  def plan_name
    self.plan.name
  end

  def location_name
    self.location.name
  end
end
