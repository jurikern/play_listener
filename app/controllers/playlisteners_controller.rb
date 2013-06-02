class PlaylistenersController < ApplicationController
  before_filter :authenticate_user!

  def synchronize
    playlists = current_user.youtube.playlists
    raise playlists.to_yaml

    redirect_to :back
  end
end