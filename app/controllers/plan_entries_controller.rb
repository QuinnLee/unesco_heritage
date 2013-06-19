class PlanEntriesController < ApplicationController
  
  def create
    @location = Location.find(params[:location_id])
    create_plan_entry
    flash[:notice] = "You have added #{@location.name} was added to #{@plan.name}"
    redirect_to user_plan_path(current_user,@plan)
  end

  def update
    @plan_entry = PlanEntry.find(params[:id])
    if @plan_entry.update_attributes(params[:plan_entry])
      flash[:notice] = " #{@plan_entry.location_name} Successfully updated!"  
      redirect_to :back
    else
      flash[:error] = "Something is wrong with the date"
      redirect_to :back
    end
  end

  def destroy
    @plan_entry = PlanEntry.find(params[:id])
    @plan = @plan_entry.plan
    @plan_entry.destroy
    flash[:notice] = "#{@plan_entry.location_name} deleted from the plan"
    redirect_to user_plan_path(current_user,@plan)
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
