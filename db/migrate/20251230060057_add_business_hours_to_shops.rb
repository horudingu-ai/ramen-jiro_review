class AddBusinessHoursToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :business_hours, :string
  end
end
