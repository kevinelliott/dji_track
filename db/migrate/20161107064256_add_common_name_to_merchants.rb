class AddCommonNameToMerchants < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :common_name, :string, null: false, default: 'MISSING COMMON NAME'
    add_index :merchants, :common_name
  end
end
