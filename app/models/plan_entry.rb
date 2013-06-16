class PlanEntry < ActiveRecord::Base
  belongs_to :plan
  belongs_to :location
  
  validates :location_id, presence: true
  validates :plan_id, presence: true

  attr_accessible :location_id, :plan_id
end
