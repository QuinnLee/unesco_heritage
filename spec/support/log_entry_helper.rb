module LogEntryHelper
  def add_a_log_entry(location)
    click_link ("View Locations")
    click_link("#{location.name}")
    fill_in "First date", with: "12/12/88"
    fill_in "Last date", with: "12/12/88"
    click_button  'Add to Log'
  end
end