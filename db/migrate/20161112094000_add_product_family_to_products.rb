class AddProductFamilyToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :product_family, foreign_key: true
  end
end
