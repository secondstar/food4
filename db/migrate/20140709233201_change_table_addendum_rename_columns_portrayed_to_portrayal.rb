class ChangeTableAddendumRenameColumnsPortrayedToPortrayal < ActiveRecord::Migration
  change_table :addendums do |t|
    t.rename :portrayed_id, :portrayal_id
    t.rename :portrayed_type, :portrayal_type
  end
end
