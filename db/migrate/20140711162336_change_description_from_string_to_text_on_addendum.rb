class ChangeDescriptionFromStringToTextOnAddendum < ActiveRecord::Migration
  def change
    change_column :addendums, :description, :text
    
  end
end
