class AddingUrl < ActiveRecord::Migration
  def up
    add_column :locations, :image_url, :string, null: false
    add_column :locations, :http_url, :string, null: false
  end

  def down
    remove_column :locations, :image_url
    remove_column :locations, :http_url
  end
end
