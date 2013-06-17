class CreatePlanEntries < ActiveRecord::Migration
  def change
    create_table :plan_entries do |t|
      t.integer :plan_id
      t.integer :location_id

      t.timestamps
    end
  end
end
