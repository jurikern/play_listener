class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :user_id, :null => false
      t.string  :uid,     :null => false, :default => ""

      t.timestamps
    end

    add_foreign_key(:playlists, :users, :dependent => :delete)
    add_index(:playlists, :uid, :unique => true)
  end
end
