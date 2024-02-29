Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/hello', to: 'greetings#hello'

  namespace :api do
    namespace :v1 do

      # USER
      match '/register', to: 'sessions#create', via: :post
      match '/login',    to: 'sessions#verify', via: :post

      # Groups | api/v1/groups
      resources :groups, only: %i[index create update] do
        # groups/:id
        member do
          delete '/', to: 'groups#delete'
        end
      end

    end
  end
end
