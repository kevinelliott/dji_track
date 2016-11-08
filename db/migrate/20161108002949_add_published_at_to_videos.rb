class AddPublishedAtToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :published_at, :datetime
    add_index :videos, :published_at
  end
end
