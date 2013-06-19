module LogEntryHelper
  def add_a_log_entry(location)
    click_link ("Locations")
    click_link("#{location.name}")
    fill_in "First date", with: "12/12/88"
    fill_in "Last date", with: "12/12/88"
    click_button  'Add to Log'
  end

  def add_a_log_entry_different_date(location)
    click_link ("Locations")
    click_link("#{location.name}")
    fill_in "First date", with: "12/12/99"
    fill_in "Last date", with: "12/12/99"
    click_button  'Add to Log'
  end
end
