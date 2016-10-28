class AddDjiUsernameToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :dji_username, :string
    add_index :orders, :dji_username
  end
end
