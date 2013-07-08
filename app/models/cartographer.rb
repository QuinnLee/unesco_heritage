## This class creates the marker points and polylines for the gmaps
## I would rather re-write the Gem, Gmaps4rails. But I ain't got no time for this

class Cartographer

  def initialize(options = {})
    @user = options[:user] 
    @location = options[:location]
    @plan = options[:plan]
  end

  def user_log_entries
    if @user.present?
      @user.log_entries.where(location_id: @location) 
    else
      []
    end
  end

  def locations_near_user
    if @user.present?
      Location.near([@user.latitude, @user.longitude], 200, :units => :km, :order => :distance)
    else
      []
    end
  end

  def users_plan_entries
    if @user.present?
      @user.plan_entries.where(location_id: @location).uniq_by(&:plan_id)
    else
      []
    end
  end

  def markers
    markers = []
    markers << JSON.parse(@location.to_gmaps4rails) if @location
    markers << user_map_marker if @user
    markers.flatten!
    markers.to_json
  end

  def polylines
    if @user.present?
      line = [log_polyline,plans_polylines].flatten.join(",")
      "[#{line}]"
    else
      "[]"
    end
  end

  def sorted_log_entries
    LogEntry.where(user_id: @user).order(:first_date)
  end

  private

  def set_plan
    if @plan.present?
      [@plan] 
    else
      @user.plans
    end
  end

  def plan_locations
    markers = set_plan.map{|plan| plan.marker }
    cleaner(markers)
  end

  def user_map_marker
    markers = []
    markers << JSON.parse(@user.to_gmaps4rails)
    plan_locations.each {|marker_set|markers << JSON.parse(marker_set)}
    markers << JSON.parse(@user.log_entries.to_gmaps4rails)
  end

  def log_polyline
    line = sorted_log_entries.map{|entry| entry.poly_line}
    line.unshift(@user.log_polyline)
    line.to_json
  end

  def users_plan_polylines
    set_plan.map {|plan| set_single_plan_polyline(plan)}
  end

  def plans_polylines
    polyline = users_plan_polylines.map{|set| set.to_json}
    cleaner(polyline)
  end

  def set_single_plan_polyline(plan)
    plan.plan_entries.map {|entry| entry.poly_line}.
      unshift(@user.plan_polyline(plan))
  end

  def cleaner(object)
    object.reject{|coordinates| coordinates == "[]"}
  end

end
