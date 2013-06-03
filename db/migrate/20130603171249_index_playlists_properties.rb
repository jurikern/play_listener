class IndexPlaylistsProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX playlists_properties ON playlists USING GIN(properties)"
  end

  def down
    execute "DROP INDEX playlists_properties"
  end
end
