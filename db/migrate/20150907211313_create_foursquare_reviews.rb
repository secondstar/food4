class CreateFoursquareReviews < ActiveRecord::Migration
  def change
    create_table :foursquare_reviews do |t|
      t.string :foursquare_id

      t.timestamps null: true
    end
  end
end
