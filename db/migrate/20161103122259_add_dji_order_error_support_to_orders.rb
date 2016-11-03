class AddDjiOrderErrorSupportToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :dji_lookup_success, :bool, null: false, default: false
    add_index :orders, :dji_lookup_success
    add_column :orders, :dji_lookup_error_code, :string
    add_index :orders, :dji_lookup_error_code
    add_column :orders, :dji_lookup_error_reason_code, :string
    add_index :orders, :dji_lookup_error_reason_code
  end
end
