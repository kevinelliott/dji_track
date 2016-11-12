class CreateProductFamilies < ActiveRecord::Migration[5.0]
  def change
    create_table :product_families do |t|
      t.references :manufacturer, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.string :logo_url
      t.string :website
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
    add_index :product_families, :status
  end
end
