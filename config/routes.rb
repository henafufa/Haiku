Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/ed'
  get 'password_resets/it'
  get 'sessions/new'
  get 'users/new'
  # root 'static_pages#home'
  # root 'post#index'
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'
  # get 'post' => 'post#index'
  root 'static_pages#home'
  # get '/users' to: 'users#index'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
