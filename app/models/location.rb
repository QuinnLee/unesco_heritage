class Location < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => false

  has_many :log_entries
  has_many :plan_entries
  
  has_many :plans, :through => :plan_entries
  has_many :users, :through => :log_entries

  validates :longitude,  presence: true
  validates :latitude,  presence: true
  validates :name,  presence: true

  attr_accessible :name, :longitude, :latitude, :category, :region, :states, :description,
    :image_url, :http_url, :description

  def gmaps4rails_address
    "#{self.latitude},#{self.longitude}"
  end

  # TODO SET AS PARTIAL
  def gmaps4rails_infowindow
    "<img src=\"#{self.image_url}\"> <a href=\" #{self.http_url} \">#{smart_truncate(self.name, words: 5)}</a>"
  end
  def gmaps4rails_title
    
  end

  def self.categories
    Location.uniq.pluck(:category)
  end

  def self.regions
    Location.uniq.pluck(:region)
  end
  #TODO refactor this

  def smart_truncate(s, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
    end
    a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? ' ' : '')
  end
end
