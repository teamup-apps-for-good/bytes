Rails.application.routes.draw do
  resources :transactions

  get 'sessions/logout'
  get 'sessions/omniauth'

  get 'users/index'
  get 'users/new'
  get 'users/show'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # action -> controller#action
  get '/users/:uin/transfer', to: 'users#transfer', as: 'user-transfer'
  post '/users/:uin/transfer/transfer_donor_credits', to: 'users#do_transfer'
end
