class AddColorToPlan < ActiveRecord::Migration
  def up
    add_column :plans, :color, :string
  end

  def down
    remove_column :plans, :color
  end
end
