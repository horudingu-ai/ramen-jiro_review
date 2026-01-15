class AddDemographicsAndCategoryRatingsToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :age_group, :integer unless column_exists?(:reviews, :age_group)
    add_column :reviews, :gender, :integer unless column_exists?(:reviews, :gender)

    add_column :reviews, :rating_taste, :integer unless column_exists?(:reviews, :rating_taste)
    add_column :reviews, :rating_service, :integer unless column_exists?(:reviews, :rating_service)
    add_column :reviews, :rating_value, :integer unless column_exists?(:reviews, :rating_value)
    add_column :reviews, :rating_cleanliness, :integer unless column_exists?(:reviews, :rating_cleanliness)
    add_column :reviews, :rating_atmosphere, :integer unless column_exists?(:reviews, :rating_atmosphere)
  end
end
