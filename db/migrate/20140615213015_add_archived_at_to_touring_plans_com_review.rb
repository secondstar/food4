class AddArchivedAtToTouringPlansComReview < ActiveRecord::Migration
  def change
    add_column :touring_plans_com_reviews, :archived_at, :datetime
  end
end
