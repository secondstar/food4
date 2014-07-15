class AddMoreTwoAttrsToTouringPlansComReview < ActiveRecord::Migration
  def change
    add_column :touring_plans_com_reviews, :dinable_id, :integer
    add_column :touring_plans_com_reviews, :dinable_type, :string
  end
end
