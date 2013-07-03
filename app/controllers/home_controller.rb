class HomeController < ApplicationController
  def index
    @location = Location.order("RANDOM()").first
    @json = @location.to_gmaps4rails if @location.present?
    if signed_in?
      flash.keep
      redirect_to locations_path
    end
  end
end
