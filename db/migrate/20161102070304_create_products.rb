class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :manufacturer, foreign_key: true, null: false
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.string :logo_url
      t.string :website
      t.string :upc
      t.string :asin
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
    add_index :products, :name
    add_index :products, :code
    add_index :products, :status
  end
end
