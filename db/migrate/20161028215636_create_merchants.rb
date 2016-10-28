class CreateMerchants < ActiveRecord::Migration[5.0]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.text :description
      t.string :website
      t.string :referral_code
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end
    add_index :merchants, :status

    Merchant.create(name: 'DJI', website: 'http://store.dji.com', status: 'active')
    Merchant.create(name: 'Amazon', website: 'http://www.amazon.com', status: 'active')
    Merchant.create(name: 'Amazon UK', website: 'http://uk.amazon.com', status: 'active')
    Merchant.create(name: 'Best Buy', website: 'http://www.bestbuy.com', status: 'active')
    Merchant.create(name: 'B&H', website: 'http://www.bhphotovideo.com', status: 'active')
    Merchant.create(name: 'NewEgg', website: 'http://www.newegg.com', status: 'active')
  end
end
