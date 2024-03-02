Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do

      get '/hello', to: 'greetings#hello'

      # Users | /api/v1
      match '/register', to: 'sessions#create', via: :post
      match '/login',    to: 'sessions#verify', via: :post

      # Groups | /api/v1/groups
      resources :groups, only: %i[index create update] do
        # /:id
        member do
          delete '/', to: 'groups#delete'
        end

        # Bunches | /:group_id/bunches
        resources :bunches, only: %i[index create]
      end

      # Cards | /api/v1/bunches/:bunch_id
      resources :bunches, only: %i[] do
        resources :cards
      end

    end
  end
end
