class AddAccessoryToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :accessory, :boolean, null: false, default: false
    add_index :products, :accessory
  end
end
