class AddDistrictIdToTouringPlansComReview < ActiveRecord::Migration
  def change
    add_column :touring_plans_com_reviews, :district_id, :integer
  end
end
