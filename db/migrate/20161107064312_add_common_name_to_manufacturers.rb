class AddCommonNameToManufacturers < ActiveRecord::Migration[5.0]
  def change
    add_column :manufacturers, :common_name, :string, null: false, default: 'MISSING COMMON NAME'
    add_index :manufacturers, :common_name
  end
end
