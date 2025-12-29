class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.integer :rating
      t.text :body
      t.date :visit_date

      t.timestamps
    end
  end
end
