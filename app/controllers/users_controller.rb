class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = current_user
    @user_log = sorted_log_entries
    @plan = @user.plans.build
    @plans = users_plans.page params[:page]

    @json = markers
    @polyline = polylines
  end

  private
  def users_plans
    Plan.users_plan(@user)
  end

  def sorted_log_entries
    LogEntry.where(user_id: @user).order(:first_date).reverse_order
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
    line=[log_polyline, clean_plan_polylines].flatten.join(",")
   "[#{line}]"    
  end

  def plan_locations
    current_user.plans.map{|plan| plan.marker }.reject{|coordinates| coordinates == "[]"}
  end

end
