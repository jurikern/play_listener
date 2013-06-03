class AddPropertiesToPlaylists < ActiveRecord::Migration
  def change
    add_column :playlists, :properties, :hstore
  end
end
