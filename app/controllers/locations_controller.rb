class LocationsController < ApplicationController
  def index
    @search = Location.search(params[:q])
    @locations = @search.result.page params[:page]

    cartographer = Cartographer.new(user: current_user, location: @locations)

    @categories = Location.categories
    @regions = Location.regions

    @json = cartographer.markers
    @polyline = cartographer.polylines if current_user
  end

  def show
    @location = Location.find(params[:id])
    cartographer = Cartographer.new(user: current_user, location: @location)

    @nearby_locations = @location.nearbys(300, :units => :km).page(params[:page]).per(10)

    @users_log_entries = cartographer.user_log_entries
    @users_plan_entries = cartographer.users_plan_entries

    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    
    @json = cartographer.markers
    @polyline = cartographer.polylines if current_user
  end  


end
