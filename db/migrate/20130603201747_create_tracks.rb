class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :playlist_id, :null => false
      t.string  :uid,         :null => false, :default => ""

      t.timestamps
    end

    add_index(:tracks, :uid, :unique => true)
    add_foreign_key(:tracks, :playlists, :dependent => :delete)
  end
end
