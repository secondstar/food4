class AddDressToTouringPlansComReview < ActiveRecord::Migration
  def change
    add_column :touring_plans_com_reviews, :dress, :string
  end
end
