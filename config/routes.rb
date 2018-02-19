Rails.application.routes.draw do
  root 'static_pages#home' # homepage view file is app/views/static_pages/home.html.erb

  get '/signin' => 'sessions#new' # rendering login form
  # get "/signin", to: "sessions#new"
  post '/sessions/create' => 'sessions#create' # receives data submitted in login form, authenticates and logs in a valid user
  # post "/sessions/create", to: "sessions#create"
  delete '/signout' => 'sessions#destroy' # logging out user
  # delete "/signout", to: "sessions#destroy"

  post '/rides/new' => 'rides#new'
  # post "/rides/new", to: "rides#new"

  resources :users

  resources :attractions
end
