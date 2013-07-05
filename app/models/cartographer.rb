class Cartographer

  def initialize(options = {})
    @user = options[:user]
    @location = options[:location]
    @plan = options[:plan]
  end

  def user_log_entries
    @user.log_entries.where(location_id: @location) if @user
  end

  def users_plan_entries
    @user.plan_entries.where(location_id: @location).uniq_by(&:plan_id) if @user
  end

  def markers
    markers = []
    markers << JSON.parse(@location.to_gmaps4rails) if @location
    markers << user_map_marker if @user
    markers.flatten!
    markers.to_json
  end

  def polylines
    line = [log_polyline, clean_plans_polylines].flatten.join(",")
   "[#{line}]"    
  end

  def sorted_log_entries
    LogEntry.where(user_id: @user).order(:first_date).reverse_order
  end

  def single_plan_polylines
    "[#{plan_polyine(@plan).to_json}]"
  end

  private

  def plans_locations
    @user.plans.map{|plan| plan.marker }.reject{|coordinates| coordinates == "[]"}
  end

  def user_map_marker
    markers = []
    plans_locations.each {|marker_set|markers << JSON.parse(marker_set)}
    markers << JSON.parse(@user.log_entries.to_gmaps4rails)
  end

  def log_polyline
    sorted_log_entries.map{|entry| entry.poly_line}.to_json
  end

  def plans_polyline
    @user.plans.map do |plan|
      plan_polyine(plan)
    end
  end

  def clean_plans_polylines
    plans_polyline.map{|set| set.to_json}.reject{|coordinates| coordinates == "[]"}
  end

  def plan_polyine(plan)
    plan.plan_entries.map do |entry|
      entry.poly_line
    end
  end

end
