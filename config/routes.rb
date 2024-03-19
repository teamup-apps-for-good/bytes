# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/logout'
  get 'sessions/omniauth'

  resources :credit_pools
  get 'sessions/logout'
  get 'sessions/omniauth'

  resources :pages
  resources :transactions
  resources :schools
  resources :meetings, only: [:index, :new, :create, :destroy]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # routes for recieving credits, the page and the actual transfer route
  get '/users/profile/receive', to: 'users#receive', as: 'user_receive'
  post '/users/profile/do_receive', to: 'users#do_receive', as: 'user_do_receive'

  # Defines the root path route ("/")
  # root "posts#index"

  # route for the actual transfer page
  root to: 'pages#index'

  # action -> controller#action
  get '/users/profile/transfer', to: 'users#transfer', as: 'user-transfer'

  # route for the post request that will be the transfer functionality
  post '/users/profile/transfer/transfer_donor_credits', to: 'users#do_transfer'

  # route for changing user_type
  post '/users/profile/update_user_type', to: 'users#update_user_type', as: 'user_update_type'

  # route to add to the credit pool
  post 'transaction/add_to_pool', to: 'credit_pools#add_to_pool'


  # oauth stuff
  get '/logout', to: 'sessions#logout', as: 'logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  get '/auth/failure', to: 'sessions#failure'

  get '/test/login', to: 'sessions#set_session', as: 'test-login'

  get '/users/profile', to: 'users#show', as: 'user-profile'
  get '/users/new', to: 'users#new', as: 'new-user'
  post '/users', to: 'users#create', as: 'create-user'
  get '/users', to: 'users#index', as: 'user-list'
end
