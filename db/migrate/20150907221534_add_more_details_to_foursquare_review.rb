class AddMoreDetailsToFoursquareReview < ActiveRecord::Migration
  def change
    add_column :foursquare_reviews, :name, :string
    add_column :foursquare_reviews, :address, :string
    add_column :foursquare_reviews, :cross_street, :string
    add_column :foursquare_reviews, :lat, :string
    add_column :foursquare_reviews, :lng, :string
  end
end
