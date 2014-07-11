class AddColunmToReviewDetailstoDfb < ActiveRecord::Migration
  def change
    add_column :disneyfoodblog_com_reviews, :service, :string
    add_column :disneyfoodblog_com_reviews, :type_of_food, :string
    add_column :disneyfoodblog_com_reviews, :location, :string
    add_column :disneyfoodblog_com_reviews, :disney_dining_plan, :string
    add_column :disneyfoodblog_com_reviews, :tables_in_wonderland, :string
    add_column :disneyfoodblog_com_reviews, :menu, :string
    add_column :disneyfoodblog_com_reviews, :important_info, :string
    add_column :disneyfoodblog_com_reviews, :famous_dishes, :string
  end
end
