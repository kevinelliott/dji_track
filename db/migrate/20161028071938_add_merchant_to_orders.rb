class AddMerchantToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :merchant, :string
    add_index :orders, :merchant
  end
end
