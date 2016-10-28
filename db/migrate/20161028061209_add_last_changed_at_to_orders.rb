class AddLastChangedAtToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :last_changed_at, :datetime
    add_index :orders, :last_changed_at
  end
end
