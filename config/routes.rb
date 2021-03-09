Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  get 'daily_challenges/index'
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
  patch "challenge", to:'users#dailyChallenge'
  patch "track", to:'daily_challenges#index'
  get "task", to:'daily_challenges#index'
  get "activities", to:'activities#index'
  get 'search_by_tag', to:'users#search_activities'
  get '/test', to: 'static_pages#test'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :activities
  resources :comments
  resources :reactions, only: [ :create, :destroy ]
  resources :microposts, only: [ :create, :destroy ]
  resources :haikus, only: [ :create, :destroy, :update, :show ]
  resources :relationships, only: [:create, :destroy]
  resources :haiku_comments
  resources :daily_challenges
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
