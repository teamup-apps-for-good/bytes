Rails.application.routes.draw do
  get 'sessions/logout'
  get 'sessions/omniauth'
  resources :users
  resources :pages
  get 'transactions/index'
  get 'transactions/new'
  get 'transactions/show'
  get 'transactions/create'
  get 'transactions/edit'
  get 'transactions/update'
  get 'transactions/search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root :to => 'pages#index'

  # action -> controller#action
  get '/users/:uin/transfer', to: 'users#transfer', as: 'user-transfer'
  post '/users/:uin/transfer/transfer_donor_credits', to: 'users#do_transfer'

  #oauth stuff
  get '/logout', to: 'sessions#logout', as: 'logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
end
