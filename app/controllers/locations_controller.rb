class LocationsController < ApplicationController
  def index
    @search = Location.search(params[:q])
    @locations = @search.result.page params[:page]
    @categories = Location.categories
    @regions = Location.regions
    @json = markers
    @polyline = polylines if current_user
  end

  def show
    @location = Location.find(params[:id])
    @nearby_locations = @location.nearbys(300, :units => :km).page(params[:page]).per(10)


    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    @users_plan_entries = users_plan_entries
    @users_log_entries = user_log_entries

    @json = markers
    @polyline = polylines if current_user
  end  

  private
  ##FACADE
  def user_log_entries
    current_user.log_entries.where(location_id: @location) if current_user
  end

  def users_plan_entries
    current_user.plan_entries.
      where(location_id: @location).uniq_by(&:plan_id) if current_user
  end

  def sorted_log_entries
    LogEntry.where(user_id: current_user).order(:first_date).reverse_order
  end

  def markers
    markers = []
    markers << JSON.parse(@locations.to_gmaps4rails) unless @locations.nil?
    markers << JSON.parse(@location.to_gmaps4rails) unless @location.nil?

    if current_user
      plan_locations.each do|marker_set|
        markers <<JSON.parse(marker_set)
      end
      markers << JSON.parse(current_user.log_entries.to_gmaps4rails)
    end

    markers.flatten!
    markers.to_json
  end

  def log_polyline
    sorted_log_entries.map{|entry| entry.poly_line}.to_json
  end

  def plan_polyline
    current_user.plans.map do |plan|
      plan.plan_entries.map do |entry|
        entry.poly_line
      end
    end
  end

  def clean_plan_polylines
    plan_polyline.map{|set| set.to_json}.reject{|coordinates| coordinates == "[]"}
  end

  def polylines
    line = [log_polyline, clean_plan_polylines].flatten.join(",")
   "[#{line}]"    
  end

  def plan_locations
    current_user.plans.map{|plan| plan.marker }.reject{|coordinates| coordinates == "[]"}
  end

end
