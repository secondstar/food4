class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.references :eatery, index: true
      t.string     :review_type
      t.references :review, index: true
      t.text       :review_permalink, index: true
      t.boolean    :review_permalink_is_different_than_eatery_permalink, :default => false, :null => false

      t.timestamps
    end
  end
end
