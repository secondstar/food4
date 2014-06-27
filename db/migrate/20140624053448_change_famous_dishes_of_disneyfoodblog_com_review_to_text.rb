class ChangeFamousDishesOfDisneyfoodblogComReviewToText < ActiveRecord::Migration
  def change
     change_column :disneyfoodblog_com_reviews, :famous_dishes, :text
  end
end
