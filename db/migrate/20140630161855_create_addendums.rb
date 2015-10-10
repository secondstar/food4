class CreateAddendums < ActiveRecord::Migration
  def change
    create_table :addendums do |t|
      t.string :source
      t.string :href
      t.string :description
      t.string :category #blogging, tip, affinity
      t.references :portrayed, polymorphic: true

      t.timestamps null: true
    end
  end
end
