class AddPhotogenicIndexToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, [:photogenic_id, :photogenic_type]
    
  end
end
