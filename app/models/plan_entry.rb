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
   "height" => 40,
   "marker_anchor" => [13, 35],
   "shadow_picture" => "/images/shadow-worldheritagesite.png",
   "shadow_width" => "110",
   "shadow_height" => "110",
   "shadow_anchor" => [13, 35]
  }
  end

  def gmaps4rails_infowindow
    "<div class='location-infobox'> <a href=/locations/#{location.id}>#{name}</a>  <p>Plan: <a href=/plans/#{plan.id}>#{plan_name}</a> <p>
      <p>Date planed: #{date}</p> <p>Located: #{states}</p> <img src=\"#{image_url}\"></div>"
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
