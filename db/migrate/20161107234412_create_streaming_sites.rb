class CreateStreamingSites < ActiveRecord::Migration[5.0]
  def change
    create_table :streaming_sites do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description

      t.timestamps
    end
    add_index :streaming_sites, :name
    add_index :streaming_sites, :code
  end
end
