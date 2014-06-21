class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :url
      t.string :farm
      t.string :server
      t.string :owner
      t.integer :photogenic_id
      t.string :photogenic_kind
      t.string :flickr_id
      t.string :title

      t.timestamps
    end
  end
end
