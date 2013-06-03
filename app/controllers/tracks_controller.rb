class TracksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :init_playlist

  def synch
    @playlist.synch_tracks
    redirect_to :back
  end

  private

  def init_playlist
    @playlist = current_user.playlists.find(params[:playlist_id])
  end
end