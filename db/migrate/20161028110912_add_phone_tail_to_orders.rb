class AddPhoneTailToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :phone_tail, :string
  end
end
