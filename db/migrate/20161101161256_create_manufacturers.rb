class CreateManufacturers < ActiveRecord::Migration[5.0]
  def change
    create_table :manufacturers do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.string :website
      t.string :support_email
      t.string :support_website
      t.string :logo_url

      t.timestamps
    end
    add_index :manufacturers, :name
    add_index :manufacturers, :code
  end
end
