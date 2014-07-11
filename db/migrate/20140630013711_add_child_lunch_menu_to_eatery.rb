class AddChildLunchMenuToEatery < ActiveRecord::Migration
  def change
    add_column :eateries, :child_lunch_menu_url, :string
  end
end
