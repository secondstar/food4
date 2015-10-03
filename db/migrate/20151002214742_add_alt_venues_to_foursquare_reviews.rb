class AddAltVenuesToFoursquareReviews < ActiveRecord::Migration
  def change
    add_column :foursquare_reviews, :alt_venues, :string
  end
end
