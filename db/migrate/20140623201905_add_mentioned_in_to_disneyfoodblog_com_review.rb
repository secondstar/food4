class AddMentionedInToDisneyfoodblogComReview < ActiveRecord::Migration
  def change
    add_column :disneyfoodblog_com_reviews, :mentioned_in, :text
  end
end
