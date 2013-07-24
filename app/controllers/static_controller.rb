class StaticController < ApplicationController
  def home
    @home = true
    @location = Location.order("RANDOM()").first
    cartographer = Cartographer.new(location: @location)
    @polyline = cartographer.polylines
    @json = cartographer.markers
    if signed_in?
      flash.keep
      redirect_to locations_path
    else
      flash[:notice] = "Sample account email:foobar@barfoo.com  pw:foobar12"
    end
  end

  def about
    @locations = Location.order("RANDOM()").limit(10)
    cartographer = Cartographer.new(location: @locations)
    @polyline = cartographer.polylines
    @json = cartographer.markers
  end
end
