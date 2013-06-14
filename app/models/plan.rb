class Plan < ActiveRecord::Base
  validates :user, presence: true
  validates :name, uniqueness: { :scope => :user_id}
  belongs_to :user
  attr_accessible :description, :name, :user_id
end
