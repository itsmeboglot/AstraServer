Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/hello', to: 'greetings#hello'

  # USER

  post '/register', to: 'sessions#create'
  post '/login', to: 'sessions#verify'

  # GROUPS

  get '/groups', to: 'groups#get_groups'
  post '/groups', to: 'groups#add'
  delete '/groups', to: 'groups#remove'
  patch '/groups', to: 'groups#update'
end
