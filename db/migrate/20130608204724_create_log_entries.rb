class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.integer :location_id
      t.integer :user_id
      t.date    :first_date
      t.date    :last_date

      t.timestamps
    end
  end
end
