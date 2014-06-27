class AddEvenMoreToDisneyfoodblogComReview < ActiveRecord::Migration
  def change
    add_column :disneyfoodblog_com_reviews, :breakfast_items, :text
    add_column :disneyfoodblog_com_reviews, :drinks, :text
    add_column :disneyfoodblog_com_reviews, :special_treats, :text
  end
end
