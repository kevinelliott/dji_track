class AddSafeIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :safe_id, :string

    Order.all.each do |o|
      o.update_attribute(:safe_id, Order.unique_safe_id)
    end
    
    change_column_null :orders, :safe_id, false
    add_index :orders, :safe_id, unique: true
  end
end
