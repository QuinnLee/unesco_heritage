class PlanEntry < ActiveRecord::Base
  belongs_to :plan
  belongs_to :location
  
  validates :location, presence: true
  validates :plan, presence: true
  
  attr_accessible :location, :plan

  def plan_name
    self.plan.name
  end
end
