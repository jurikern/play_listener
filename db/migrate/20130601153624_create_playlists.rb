class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
