class HomeController < ApplicationController
  def index
    redirect_to playlists_path if user_signed_in?
  end
end