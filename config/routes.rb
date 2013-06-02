PlayListener::Application.routes.draw do
  devise_for :users, :path => "", :skip => [:sessions, :registration], :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do
    get "login",  to: "users/sessions#new",     as: :login
    get "logout", to: "users/sessions#destroy", as: :logout
  end

  resources :playlists

  root :to => "application#index"
end
