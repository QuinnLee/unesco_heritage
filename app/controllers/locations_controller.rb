class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
    @log_entry = @location.log_entries.build
    user_log_entries
  end  

  protected
  def user_log_entries
    @users_log_entries = current_user.log_entries.
      where(location_id: @location)if current_user
  end
end
