class IndexTracksProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX tracks_properties ON tracks USING GIN(properties)"
  end

  def down
    execute "DROP INDEX tracks_properties"
  end
end
