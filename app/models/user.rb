class User < ActiveRecord::Base
  has_many :playlists

  devise :database_authenticatable, :encryptable, :omniauthable, :omniauth_providers => [:google_oauth2]

  serialize :properties, ActiveRecord::Coders::Hstore

  %w[yid username avatar_url].each do |key|
    define_method(key) do
      properties && properties[key]
    end

    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end

  @youtube = nil

  scope :by_uid, ->(uid) {where(:uid => uid)}

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    user = User.by_uid(auth.uid).first

    user = User.new unless user

    user.name          = auth.info.name
    user.email         = auth.info.email
    user.uid           = auth.uid
    user.access_token  = auth.credentials.token
    user.refresh_token = auth.credentials.refresh_token
    user.password      = Devise.friendly_token[10,20]

    begin
      profile = user.youtube.profile
    rescue
      profile = nil
    end

    if profile
      user.yid        = profile.user_id
      user.username   = profile.username_display
      user.avatar_url = profile.avatar
    end

    user.save!
    user
  end

  def youtube
    @youtube ||= YouTubeIt::OAuth2Client.new(
        client_access_token:  self.access_token,
        client_refresh_token: self.refresh_token,
        client_id:            GOOGLE_OAUTH2_CLIENT_ID,
        client_secret:        GOOGLE_OAUTH2_CLIENT_SECRET,
        dev_key:              GOOGLE_API_KEY
    )
  end

  def refresh_access_token!
    unless new_record?
      self.access_token = youtube.refresh_access_token!.token
      save!
    else
      false
    end
  end

  def check_access_token!
    if youtube.session_token_info[:code] == 200
      true
    else
      refresh_access_token!
    end
  end

  def synch_playlists
    if check_access_token!
      remote_playlists = youtube.playlists
      remote_playlists.each do |remote_playlist|
        playlist              = playlists.by_uid(remote_playlist.playlist_id).first || playlists.build
        playlist.uid          = remote_playlist.playlist_id if playlist.new_record?
        playlist.title        = remote_playlist.title
        playlist.summary      = remote_playlist.summary
        playlist.description  = remote_playlist.description
        playlist.published_at = remote_playlist.published
        playlist.save!
      end
    end
  end
end
