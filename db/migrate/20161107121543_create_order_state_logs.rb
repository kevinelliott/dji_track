class CreateOrderStateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :order_state_logs do |t|
      t.references :order, foreign_key: true
      t.string :column, null: false
      t.string :from
      t.string :to

      t.timestamps
    end
    add_index :order_state_logs, :column
    add_index :order_state_logs, :from
    add_index :order_state_logs, :to
  end
end
