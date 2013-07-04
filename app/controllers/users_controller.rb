class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    cartographer = Cartographer.new(user: current_user)
    @user_log = cartographer.sorted_log_entries
    @plan = current_user.plans.build
    @plans = current_user.plans.page params[:page]

    
    @json = cartographer.markers
    @polyline = cartographer.polylines
  end

end
