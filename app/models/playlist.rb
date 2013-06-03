class Playlist < ActiveRecord::Base
  belongs_to :user

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
        raise video.to_yaml
      end
    end
  end
end
