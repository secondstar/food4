class AddNameIndexToDistricts < ActiveRecord::Migration
  def change
    add_index :districts, [:name]
    
  end
end
