class CreateTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :terms do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    add_index :terms, :name
  end
end
