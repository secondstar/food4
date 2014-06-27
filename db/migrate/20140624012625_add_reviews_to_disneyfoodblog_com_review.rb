class AddReviewsToDisneyfoodblogComReview < ActiveRecord::Migration
  def change
    add_column :disneyfoodblog_com_reviews, :reviews, :text
  end
end
