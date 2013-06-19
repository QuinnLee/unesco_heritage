class PlanEntriesController < ApplicationController
  
  def create
    @location = Location.find(params[:location_id])
    @plan_entry = @location.plan_entries.build(params[:plan_entry])
    if @plan_entry.save
      flash[:notice] = "You have added #{@location.name} was added to #{@plan_entry.plan_name}"
      redirect_to user_plan_path(current_user,@plan_entry.plan)
    else
      flash[:error] = "Blah"
      redirect_to location_path(@location)
    end
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

end
