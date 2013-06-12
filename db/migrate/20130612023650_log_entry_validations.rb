class LogEntryValidations < ActiveRecord::Migration
  def up
    change_column :log_entries, :location_id, :integer, null: false
    change_column :log_entries, :user_id, :integer, null: false
    change_column :log_entries, :first_date, :date, null: false
    change_column :log_entries, :last_date, :date, null: false
  end

  def down
    change_column :log_entries, :location_id, :integer
    change_column :log_entries, :user_id, :integer
    change_column :log_entries, :first_date, :date
    change_column :log_entries, :last_date, :date
  end
end
