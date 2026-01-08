class AddLatitudeAndLongitudeToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :latitude,  :decimal, precision: 10, scale: 6
    add_column :shops, :longitude, :decimal, precision: 10, scale: 6
  end
end