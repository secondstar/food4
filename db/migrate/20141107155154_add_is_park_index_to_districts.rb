class AddIsParkIndexToDistricts < ActiveRecord::Migration
  def change
    add_index :districts, [:is_park]
  end
end
