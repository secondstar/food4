class CreateDisneyfoodblogComReviews < ActiveRecord::Migration
  def change
    create_table :disneyfoodblog_com_reviews do |t|
      t.string :name
      t.string :permalink
      t.datetime :archived_at

      t.timestamps null: true
    end
  end
end
