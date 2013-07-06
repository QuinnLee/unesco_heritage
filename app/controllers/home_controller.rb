class HomeController < ApplicationController
  def index
    @location = Location.order("RANDOM()").first
    cartographer = Cartographer.new(location: @location)
    @polyline = cartographer.polylines
    @json = cartographer.markers
    if signed_in?
      flash.keep
      redirect_to locations_path
    end
  end
end
