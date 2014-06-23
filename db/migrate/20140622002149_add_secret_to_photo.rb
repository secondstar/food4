class AddSecretToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :secret, :string
  end
end
