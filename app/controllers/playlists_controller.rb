class PlaylistsController < ApplicationController
  before_filter :authenticate_user!

  def synch
    current_user.synch_playlists

    redirect_to :back
  end
end