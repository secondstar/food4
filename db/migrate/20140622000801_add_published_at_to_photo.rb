class AddPublishedAtToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :published_at, :datetime
  end
end
