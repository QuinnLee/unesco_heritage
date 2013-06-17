class Plan < ActiveRecord::Base
  validates :user, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { :scope => :user_id}
  
  belongs_to :user
  has_many :plan_entries, :dependent => :destroy
  has_many :locations, :through => :plan_entries
  
  attr_accessible :description, :name, :user_id
end
