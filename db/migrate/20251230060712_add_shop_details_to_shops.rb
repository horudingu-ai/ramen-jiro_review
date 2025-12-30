class AddShopDetailsToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :access, :text
    add_column :shops, :notes, :text
  end
end
