class PlanEntriesController < ApplicationController
  
  def create
    @location = Location.find(params[:location_id])
    @plan_entry = @location.plan_entries.build()
    set_plan

    if @plan_entry.save
      flash[:notice] = "You have added #{@location.name} was added to #{@plan_entry.plan_name}"
      redirect_to plan_path(@plan_entry.plan)
    else
      flash[:error] = "What??! How can a Plan not have a NAME!?!?"
      redirect_to location_path(@location)
    end
  end

  def update
    @plan_entry = PlanEntry.find(params[:id])
    if @plan_entry.update_attributes(params[:plan_entry])
      flash[:notice] = " #{@plan_entry.location_name} Successfully updated! w00t!"  
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
    redirect_to plan_path(@plan)
  end

  private

  def set_plan
    plan_id = params[:plan_entry][:plan_id]
    @plan_entry.plan = Plan.find(plan_id) unless plan_id.empty?
     
  end

end
