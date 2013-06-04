class AddPropertiesToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :properties, :hstore
  end
end
