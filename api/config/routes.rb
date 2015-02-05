Rails.application.routes.draw do
  get 'secrets/show'

  namespace :api, :defaults => {:format => :json } do
    resources :players, only: [:index, :show]
    resources :box_scores, only: [:index, :show]
    resources :leagues, only: [:index, :show, :create]
    resources :fantastic_teams, only: [:create, :show, :index]
    resources :conferences, only: [:index]
    resources :divisions, only: [:index]
    devise_for :users
  end
end
