class AddAgeGroupAndGenderToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :age_group, :integer
    add_column :reviews, :gender, :integer
  end
end
