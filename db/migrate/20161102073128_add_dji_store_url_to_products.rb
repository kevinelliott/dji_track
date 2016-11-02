class AddDjiStoreUrlToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :dji_store_url, :string
  end
end
