class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body
      t.datetime :published_at
      t.string :status, null: false, default: 'draft'

      t.timestamps
    end
    add_index :articles, :published_at
    add_index :articles, :status
  end
end
