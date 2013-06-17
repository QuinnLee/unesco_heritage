class PlanEntriesController < ApplicationController
  
  def create
    @location = Location.find(params[:location_id])
    create_plan_entry
    flash[:notice] = "You have added #{@location.name} was added to #{@plan.name}"
    redirect_to user_path(current_user)
  end
  
  protected
    def create_plan_entry
      @plan_entry = @location.plan_entries.build(params[:plan_entry])
      set_plan
      @plan_entry.save!
    end

    def set_plan
      @plan = Plan.find(params[:plan][:id])
      @plan_entry.plan = @plan
    end
end
