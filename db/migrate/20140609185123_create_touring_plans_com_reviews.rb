class CreateTouringPlansComReviews < ActiveRecord::Migration
  def change
    create_table :touring_plans_com_reviews do |t|
      t.string :name
      t.string :permalink

      t.timestamps
    end
  end
end
