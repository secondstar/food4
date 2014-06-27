class ChangeStringFieldsOfDisneyfoodblogComReviewToText < ActiveRecord::Migration
  def change
    change_column :disneyfoodblog_com_reviews, :menu, :text
    change_column :disneyfoodblog_com_reviews, :location, :text
    change_column :disneyfoodblog_com_reviews, :menu, :text
    change_column :disneyfoodblog_com_reviews, :important_info, :text
  end
end
