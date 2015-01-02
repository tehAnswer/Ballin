Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json } do
    resources :players, only: :index
    resources :box_scores, only: :index
    resources :leagues, only: [:index, :show, :create] do
      resources :division do
        resources :fantastic_teams, only: :create
      end
    end
  end
end
