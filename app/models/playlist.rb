class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many   :tracks

  serialize :properties, ActiveRecord::Coders::Hstore

  %w[title summary description published_at].each do |key|
    define_method(key) do
      properties && properties[key]
    end

    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end

  scope :by_uid, ->(uid) {where(:uid => uid)}

  def remote
    user.youtube.playlist(uid)
  end

  def synch_tracks
    if user.check_access_token!
      remote.videos.each do |video|
        track               = tracks.by_uid(video.unique_id).first || tracks.build
        track.uid           = video.unique_id if track.new_record?
        track.title         = video.title
        track.description   = video.description
        track.player_url    = video.player_url
        track.thumbnail_url = video.thumbnails.first.url
        track.published_at  = video.published_at
        track.duration      = video.duration
        track.save!
      end
    end
  end
end
