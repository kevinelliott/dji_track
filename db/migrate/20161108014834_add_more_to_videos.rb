class AddMoreToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :thumbnail_url_small, :string
    add_column :videos, :thumbnail_url_medium, :string
    add_column :videos, :thumbnail_url_large, :string
    add_column :videos, :embed_url, :string
    add_column :videos, :embed_code, :text
    add_column :videos, :provider_published_at, :datetime
    add_column :videos, :duration, :integer
  end
end
