class LocationsController < ApplicationController
  before_filter :force_geocode!

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

    @log_entry = @location.log_entries.build
    @plan_entry = @location.plan_entries.build
    
    @json = cartographer.markers

    if current_user
      @polyline = cartographer.polylines
      @users_log_entries = cartographer.user_log_entries
      @users_plan_entries = cartographer.users_plan_entries
    end

  end  

  private 
  ## Devise and Geocode interaction requires this
  def force_geocode!
    current_user.geocode unless current_user.latitude.present? && current_user.longitude.present?
  end

end
