class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string  :name
      t.string  :permalink
      t.boolean :is_park
      t.string  :credit
      t.string  :photo_url
      t.string  :flickr_search_term

      t.timestamps null: true
    end
  end
end
