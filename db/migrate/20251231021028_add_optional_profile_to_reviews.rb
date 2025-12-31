class AddOptionalProfileToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :gender, :integer
    add_column :reviews, :age, :integer
  end
end
