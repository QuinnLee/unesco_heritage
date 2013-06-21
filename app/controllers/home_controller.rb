class HomeController < ApplicationController
  def index
    @user = User.new
    if signed_in?
      flash.keep
      redirect_to locations_path
    end
  end
end
