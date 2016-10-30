class RemoveMerchantFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :merchant
  end
end
