class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    user_location_plan_entry
    user_log_entries
  end  

  protected
  def user_log_entries
    @users_log_entries = current_user.log_entries.
      where(location_id: @location)if current_user
  end

  def user_plans
    @users_plans = Plan.joins(:user).where(user_id: current_user)
  end

  def location_plan_entries
    @locations_plan_entries = PlanEntry.joins(:location).where(location_id: @location)
  end

  def user_location_plan_entry
    user_plans
    location_plan_entries
    binding.pry
  end

end
