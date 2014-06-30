class AddWhenToGoToEatery < ActiveRecord::Migration
  def change
    add_column :eateries, :when_to_go, :string
  end
end
