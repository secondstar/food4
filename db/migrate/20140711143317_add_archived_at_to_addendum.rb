class AddArchivedAtToAddendum < ActiveRecord::Migration
  def change
    add_column :addendums, :archived_at, :datetime
  end
end
