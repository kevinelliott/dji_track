class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :owner_id
      t.string :order_id
      t.datetime :order_time
      t.string :payment_status
      t.string :payment_method
      t.string :payment_total
      t.string :shipping_address
      t.string :shipping_address_line_2
      t.string :shipping_city
      t.string :shipping_region_code
      t.string :shipping_postal_code
      t.string :shipping_country
      t.string :shipping_country_code
      t.string :shipping_phone
      t.string :shipping_status
      t.string :shipping_company
      t.string :tracking_number
      t.string :email_address
      t.string :access_key

      t.timestamps
    end
    add_index :orders, :owner_id
    add_index :orders, :order_id
    add_index :orders, :order_time
    add_index :orders, :payment_status
    add_index :orders, :shipping_city
    add_index :orders, :shipping_region_code
    add_index :orders, :shipping_postal_code
    add_index :orders, :shipping_country
    add_index :orders, :shipping_country_code
    add_index :orders, :shipping_status
    add_index :orders, :shipping_company
    add_index :orders, :email_address
  end
end
