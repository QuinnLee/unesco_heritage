class AddingLongLatLocation < ActiveRecord::Migration
  def up
    add_column :locations, :latitude, :float, null: false
    add_column :locations, :longitude, :float, null: false
  end

  def down
    remove_column :locations, :latitude
    remove_column :locations, :longitude
  end
end
