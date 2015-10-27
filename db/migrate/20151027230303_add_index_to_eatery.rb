class AddIndexToEatery < ActiveRecord::Migration
  def change
    add_index :eateries, [:name, :type_of_food]
    
  end
end
