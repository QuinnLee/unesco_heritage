class LocationsController < ApplicationController
  def index
    @search = Location.search(params[:q])
    @locations = @search.result.page params[:page]
    @json = @locations.to_gmaps4rails
  end

  def show
    @location = Location.find(params[:id])
    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    users_plan_entries
    user_log_entries
  end  

  protected
  def user_log_entries
    @users_log_entries = current_user.log_entries.
      where(location_id: @location) if current_user
  end

  def users_plan_entries
    @users_plan_entries = current_user.plan_entries.
      where(location_id: @location).uniq_by(&:plan_id) if current_user
  end  

end
