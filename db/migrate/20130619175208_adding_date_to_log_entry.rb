class AddingDateToLogEntry < ActiveRecord::Migration
  def up
    add_column :plan_entries, :date, :date
  end

  def down
    remove_column :plan_entries, :date 
  end
end
