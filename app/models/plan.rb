class Plan < ActiveRecord::Base
  validates :user, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { :scope => :user_id}
  
  belongs_to :user
  has_many :plan_entries, :dependent => :destroy
  has_many :locations, :through => :plan_entries
  
  def marker
    self.plan_entries.to_gmaps4rails
  end

  attr_accessible :description, :name, :user_id

  def self.users_plan(user)
   Plan.where(user_id: user)
  end

end
