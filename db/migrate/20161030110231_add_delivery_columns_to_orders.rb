class AddDeliveryColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :estimated_delivery_at, :datetime
    add_index :orders, :estimated_delivery_at
    add_column :orders, :delivery_status, :string, default: 'pending'
    add_index :orders, :delivery_status
    add_column :orders, :delivered_at, :datetime
    add_index :orders, :delivered_at
  end
end
