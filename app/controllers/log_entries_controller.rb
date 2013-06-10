class LogEntriesController < ApplicationController  
  def create
    @location = Location.where(id: params[:location_id]).first
    @log_entry = @location.log_entries.create(params[:log_entry])
    flash[:notice] = "You have added #{@location.name} to you log"
    redirect_to user_path(current_user)
  end
  def destroy
  end
end
