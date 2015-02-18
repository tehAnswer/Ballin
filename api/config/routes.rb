Rails.application.routes.draw do

  namespace :api, :defaults => {:format => :json } do
    resources :players, only: [:index, :show]
    resources :box_scores, only: [:index, :show]
    resources :leagues, only: [:index, :show, :create] do 
      resources :auctions, only: [:index, :create]
    end
    resources :fantastic_teams, only: [:create, :show, :index]
    resources :conferences, only: [:index]
    resources :divisions, only: [:index]
    resources :bids, only: [:index, :create]
    devise_for :users
  end

  get '/me', to: 'me#whoiam'
end
