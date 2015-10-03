class AddSearchedForToFoursquareReviews < ActiveRecord::Migration
  def change
    add_column :foursquare_reviews, :searched_for, :string
  end
end
