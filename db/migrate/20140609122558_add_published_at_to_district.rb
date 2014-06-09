class AddPublishedAtToDistrict < ActiveRecord::Migration
  def change
    add_column :districts, :published_at, :datetime
  end
end
