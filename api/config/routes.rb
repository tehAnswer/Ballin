Rails.application.routes.draw do

  namespace :api, :defaults => {:format => :json } do
    resources :players, only: [:index, :show]
    resources :contracts, only: [:index, :destroy]
    resources :box_scores, only: [:index, :show]
    resources :leagues, only: [:index, :show, :create] do 
      resources :auctions, only: [:index, :create]
    end
    resources :fantastic_teams, only: [:create, :show, :index]
    resources :conferences, only: [:index]
    resources :divisions, only: [:index]
    resources :bids, only: [:index, :create]
    resources :rotations, only: [:show, :update]
    resources :games, only: [:index, :show]
    resources :nba_teams, only: [:index, :show]
    devise_for :users
  end

  get '/me', to: 'me#whoiam'
  get '/my_team', to: 'me#my_team'
end
