class AddAgeGroupAndGenderToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :age_group, :integer unless column_exists?(:reviews, :age_group)
    add_column :reviews, :gender, :integer    unless column_exists?(:reviews, :gender)
  end
end
