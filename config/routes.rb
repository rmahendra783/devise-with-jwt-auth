# Rails.application.routes.draw do
#   require 'sidekiq/web'
#   mount Sidekiq::Web => '/sidekiq'

#   post '/login', to: 'sessions#create'
#   delete '/logout', to: 'sessions#destroy'
#   post "/auth/login", to: "authentication#login"
#   resources :users
#   resources :posts
#   resources :comments
#  end
# end
require 'sidekiq/web'
Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post "/auth/login", to: "authentication#login"
  resources :users
  resources :posts
  resources :comments
end
