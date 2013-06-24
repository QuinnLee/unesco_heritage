class AddShortAndLongDescriptions < ActiveRecord::Migration
  def up
    add_column :locations, :description, :text, null: false
  end

  def down
    remove_column :locations, :description
  end
end
