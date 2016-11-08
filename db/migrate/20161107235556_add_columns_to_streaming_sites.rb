class AddColumnsToStreamingSites < ActiveRecord::Migration[5.0]
  def change
    add_column :streaming_sites, :website, :string
    add_column :streaming_sites, :logo_url, :string
  end
end
