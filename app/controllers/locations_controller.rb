class LocationsController < ApplicationController
  def index
    @search = Location.search(params[:q])
    @locations = @search.result.page params[:page]
    if user_signed_in?
      @json = set_user_locations(@locations)
      @polylines = set_visited_path
    else
      @json = set_location(@locations)
    end
  end

  def show
    @location = Location.find(params[:id])
    @nearby_locations = @location.nearbys(500).page params[:page]
    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    if user_signed_in?
      @json = "#{near_by_locations(@nearby_locations).chomp("]")}, #{set_user_locations(@location)[1..-1]}"
      @polylines = set_visited_path
    else
      @json = set_location(@location)
    end
    users_plan_entries
    user_log_entries
  end  

  private
  def user_log_entries
    @users_log_entries = current_user.log_entries.
      where(location_id: @location) if current_user
  end

  def users_plan_entries
    @users_plan_entries = current_user.plan_entries.
      where(location_id: @location).uniq_by(&:plan_id) if current_user
  end

  #TODO REFACTOR
  def set_user_locations(locations)
    users_and_page_locations(locations).to_gmaps4rails do |location, marker|
      if user_visited_location?(location)
        marker.picture({picture: location.image_url, width: 60, height:60, })
      else
        marker.picture({picture: "/images/worldheritagesite.png", width: 30, height: 60})
      end
    end
  end

  def set_location(locations)
    locations.to_gmaps4rails do |location, marker|
      marker.picture({picture: "/images/worldheritagesite.png", width: 30, height: 60})
      marker.json({ id: location.id, coord: location.gmaps4rails_address})
    end
  end

  def near_by_locations(locations)
    locations.to_gmaps4rails do |location, marker|
      marker.picture({picture: "/images/recycle.png", width: 30, height: 60})
      marker.json({ id: location.id, coord: location.gmaps4rails_address})
    end
  end

  ## Get each plans
  # def set_plan_locations
  #   current_user.plans.map{|plan| plan.locations}
  # end


  ## Mapping out user travel log
  def set_visited_path
    "[#{user_travel_path.to_gmaps4rails}]"
  end

  def user_visited_location?(location)
    current_user.locations.include? location
  end

  def users_and_page_locations(locations)
     Array(locations)+ current_user.locations
  end

  def user_travel_path
    current_user.locations.order('log_entries.first_date DESC')
  end
end
