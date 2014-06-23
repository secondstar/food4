class CreateEatery < ActiveRecord::Migration
  def change
    create_table :eateries do |t|
      t.string :name
      t.string :permalink
      t.datetime :published_at
      
      t.timestamps
    end
  end
end
