class AddArchivedAtToFoursquareReview < ActiveRecord::Migration
  def change
    add_column :foursquare_reviews, :archived_at, :datetime
  end
end
