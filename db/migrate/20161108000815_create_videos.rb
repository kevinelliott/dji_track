class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.references :streaming_site, foreign_key: true
      t.string :title, null: false
      t.text :summary, null: false
      t.text :description
      t.string :url, null: false
      t.string :channel_name
      t.string :channel_url
      t.references :user, foreign_key: true
      t.string :status, null: false, default: 'pending-review'

      t.timestamps
    end
    add_index :videos, :channel_name
    add_index :videos, :status
  end
end
