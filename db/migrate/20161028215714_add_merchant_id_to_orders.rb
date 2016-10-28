class AddMerchantIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :merchant_id, :integer, null: false, default: 1
    add_index :orders, :merchant_id
  end
end
