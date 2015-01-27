Rails.application.routes.draw do
  get 'secrets/show'

  namespace :api, :defaults => {:format => :json } do
    resources :players, only: [:index, :show]
    resources :box_scores, only: [:index, :show]
    resources :leagues, only: [:index, :show, :create] do
      resources :division do
        resources :fantastic_teams, only: :create
      end
    end
    devise_for :users
  end
end
