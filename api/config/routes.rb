Rails.application.routes.draw do
  namespace :api do
    resources :players, only: :index do
      resources :box_scores, only: :index
    end

    resources :leagues, only: [:index, :show, :create] do
      resources :division do
        resources :fantastic_teams, only: :create
      end
    end
  end
end
