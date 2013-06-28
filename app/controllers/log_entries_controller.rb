class LogEntriesController < ApplicationController   
  def create
    @location = Location.find(params[:location_id]) 
    if create_log_entry  
      flash[:notice] = "You have added #{@location.name} to you log"
      redirect_to user_path(current_user)
    else
      flash[:error] = "This entry is invalid"
      redirect_to location_path(@location)
    end
  end

  def destroy
    @location = Location.find(params[:location_id])
    @log_entry = @location.log_entries.find(params[:id])
    @log_entry.destroy
    redirect_to user_path(current_user)
  end

  protected
  def create_log_entry
    @log_entry = @location.log_entries.build(params[:log_entry])  
    set_dates
    set_user
    check_if_valid
  end

  def check_if_valid
    @log_entry.save! if @log_entry.valid?
  end

  def set_dates
    params[:log_entry].each do |variable,date|
      @log_entry.set_first_date(date) if variable == "first_date"
      @log_entry.set_last_date(date) if variable == "last_date"
    end
  end

  def set_user
    @log_entry.user = current_user
  end
  
end
