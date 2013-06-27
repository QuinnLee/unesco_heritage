class LocationsController < ApplicationController
  def index
    @search = Location.search(params[:q])
    @locations = @search.result.page params[:page]
    @json = markers
    @polyline = polylines
  end

  def show
    @location = Location.find(params[:id])
    @nearby_locations = @location.nearbys(500, :units => :km).page params[:page]
    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    @users_plan_entries = users_plan_entries
    @users_log_entries = user_log_entries

    @polyline = polylines
    @json = markers
  end  

  private
  def user_log_entries
    current_user.log_entries.where(location_id: @location) if current_user
  end

  def users_plan_entries
    current_user.plan_entries.
      where(location_id: @location).uniq_by(&:plan_id) if current_user
  end

  def sorted_log_entries
    current_user.log_entries.sort_by {|entry| entry.first_date}
  end

  def markers
    markers = []
    markers << JSON.parse(@locations.to_gmaps4rails) unless @locations.nil?
    markers << JSON.parse(@location.to_gmaps4rails) unless @location.nil?
    markers << JSON.parse(current_user.log_entries.to_gmaps4rails) if current_user

    if current_user
      plan_locations.each do|marker_set|
        markers <<JSON.parse(marker_set)
      end
    end

    markers.flatten!
    markers.to_json
  end

  def log_polyline
    line = sorted_log_entries.map{|entry| entry.poly_line}.to_json
  end

  def polylines
    line =''
    line << log_polyline if current_user
    
  "[#{line}]"    
  end

  def plan_locations
    current_user.plans.map{|plan| plan.marker }.reject{|coordinates| coordinates == "[]"}
  end


  #TODO REFACTOR


  # ## Get each plans
  # # def set_plan_locations
  # #   current_user.plans.map{|plan| plan.locations}
  # # end


  # ## Mapping out user travel log
  # def set_visited_path
  #   "[#{user_travel_path.to_gmaps4rails}]"
  # end

  # def user_visited_location?(location)
  #   current_user.locations.include? location
  # end

  # def users_and_page_locations(locations)
  #    Array(locations)+ current_user.locations
  # end

  # def user_travel_path
  #   current_user.locations.order('log_entries.first_date DESC')
  # end
end
