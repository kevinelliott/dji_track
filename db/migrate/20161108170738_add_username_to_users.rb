class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string

    User.all.each do |u|
      u.update(username: ('a'..'z').to_a.shuffle[0,8].join)
    end
    
    change_column_null :users, :username, false
    add_index :users, :username, unique: true
  end
end
