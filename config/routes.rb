Rails.application.routes.draw do
  
  get 'password_resets/new'
  get 'password_resets/ed'
  get 'password_resets/it'
  get 'sessions/new'
  get 'users/new'
  get 'users/:id/private_post', to: 'users#private_post'
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
  delete '/logout', to: 'sessions#destroy'
  get 'search', to:'users#search'
  get 'search_user', to:'users#search_user'
  get 'challenges', to:'challenge_users#show'
  get '/test', to: 'static_pages#test'
  get '/challenge_user', to: 'challenges#challenge_user'
  post '/search_user', to: 'challenge_users#create'
  delete '/search_user', to: 'challenge_users#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :comments
  resources :reactions, only: [ :create, :destroy ]
  resources :haiku_reactions, only: [:create, :destroy, :edit]
  resources :microposts, only: [ :create, :destroy ]
  resources :haikus, only: [ :create, :destroy, :update, :show ]
  resources :relationships, only: [:create, :destroy]
  resources :haiku_comments

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
