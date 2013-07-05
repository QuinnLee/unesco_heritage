class Plan < ActiveRecord::Base
  before_save :set_color
  
  validates :user, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { :scope => :user_id}
  
  belongs_to :user
  has_many :plan_entries, :dependent => :destroy
  has_many :locations, :through => :plan_entries
  
  attr_accessible :description, :name, :user, :color

  def set_color
    self.color = random_color
  end

  def self.users_plan(user)
   Plan.where(user_id: user)
  end

  def marker
    self.plan_entries.to_gmaps4rails
  end
  
  private
  def random_color
    "#%06x" % (rand * 0xffffff)
  end
end
