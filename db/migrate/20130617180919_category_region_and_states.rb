class CategoryRegionAndStates < ActiveRecord::Migration
  def up
    add_column :locations, :category, :string, null: false
    add_column :locations, :region, :string, null: false
    add_column :locations, :states, :string, null: false
  end

  def down
    remove_column :locations, :category
    remove_column :locations, :region
    remove_column :locations, :states
  end
end
