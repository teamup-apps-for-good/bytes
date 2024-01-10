Rails.application.routes.draw do
  get 'sessions/logout'
  get 'sessions/omniauth'

  resources :credit_pools
  get 'sessions/logout'
  get 'sessions/omniauth'

  resources :users
  resources :pages
  resources :transactions
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'transactions/receive', to: 'transactions#receive', as: 'transaction_receive'
  post 'transactions/do_receive', to: 'transactions#do_receive', as: 'transaction_do_receive'

  # Defines the root path route ("/")
  # root "posts#index"

  #route for the actual transfer page
  root :to => 'pages#index'

  # action -> controller#action
  get '/users/:id/transfer', to: 'users#transfer', as: 'user-transfer'

  #route for the post request that will be the transfer functionality
  post '/users/:id/transfer/transfer_donor_credits', to: 'users#do_transfer'

  # route to add to the credit pool
  post 'transaction/add_to_pool', to: 'credit_pools#add_to_pool'

  #oauth stuff
  get '/logout', to: 'sessions#logout', as: 'logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
end
