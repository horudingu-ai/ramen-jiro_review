class AddClosedDaysToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :closed_days, :string
  end
end
