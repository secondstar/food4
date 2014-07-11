class AddYouMightAlsoLikeToDisneyfoodblogComReview < ActiveRecord::Migration
  def change
    add_column :disneyfoodblog_com_reviews, :you_might_also_like, :text
  end
end
