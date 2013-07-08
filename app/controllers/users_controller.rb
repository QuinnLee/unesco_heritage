class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    cartographer = Cartographer.new(user: current_user)
    @user_log = cartographer.sorted_log_entries
    @plan = current_user.plans.build
    @plans = current_user.plans.page params[:page]
    @recomended = cartographer.locations_near_user.page(params[:page]).per(10)
    @json = cartographer.markers
    @polyline = cartographer.polylines
  end

end
