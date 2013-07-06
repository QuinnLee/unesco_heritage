class User < ActiveRecord::Base
  include Gravatar

  acts_as_gmappable :process_geocoding => false

  geocoded_by :current_sign_in_ip,
    :latitude => :latitude, :longitude => :longitude
  
  after_validation :geocode,
    :if => lambda{ |obj| obj.current_sign_in_ip_changed? }


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :log_entries, :dependent => :destroy
  has_many :locations, :through => :log_entries

  has_many :plans, :dependent => :destroy
  has_many :plan_entries, :through => :plans

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :longitude, :latitude
  # attr_accessible :title, :body  

  def gmaps4rails_address
    "#{latitude},#{longitude}"
  end

  def gmaps4rails_marker_picture
  {
   "picture" => avatar_url(self),
   "width" => 40,
   "height" => 40
  }
  end

  def log_polyline
     Hash['lng', longitude , 'lat', latitude, "strokeColor", "#00000", "strokeWeight", 3]
  end

  def plan_polyline(plan)
    Hash['lng', longitude , 'lat', latitude, "strokeColor", plan.color, "strokeWeight", 3]
  end

end
