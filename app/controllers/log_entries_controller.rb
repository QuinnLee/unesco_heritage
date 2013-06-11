class LogEntriesController < ApplicationController 
  def create
    @location = Location.find(params[:location_id])
    create_log_entry
    flash[:notice] = "You have added #{@location.name} to you log"
    redirect_to user_path(current_user)
  end

  def destroy
    @location = Location.find(params[:location_id])
    @log_entry = @location.log_entries.find(params[:id])
    @log_entry.destroy
    redirect_to user_path(current_user)
  end

  protected
  def create_log_entry
    @log_entry = @location.log_entries.create(params[:log_entry])
    @log_entry.user = current_user
    @log_entry.save!
  end

end
