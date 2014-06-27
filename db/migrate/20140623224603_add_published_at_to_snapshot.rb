class AddPublishedAtToSnapshot < ActiveRecord::Migration
  def change
    add_column :snapshots, :published_at, :datetime
  end
end
