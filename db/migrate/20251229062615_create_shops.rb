class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :area
      t.text :description

      t.timestamps
    end
  end
end
