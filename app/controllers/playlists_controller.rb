class PlaylistsController < ApplicationController
  before_filter :authenticate_user!

  def new
    favorites = current_user.youtube.profile.to_yaml
    raise favorites.to_yaml
  end

  def create

  end
end