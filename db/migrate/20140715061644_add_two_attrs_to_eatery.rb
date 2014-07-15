class AddTwoAttrsToEatery < ActiveRecord::Migration
  def change
    add_column :eateries, :dinable_id, :integer
    add_column :eateries, :dinable_type, :string
  end
end
