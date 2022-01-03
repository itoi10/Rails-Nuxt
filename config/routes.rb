Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'

  # セッション
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :microposts, only: [:create, :destroy]

  # GET     /users            | index
  # GET     /users/<:id>      | show
  # GET     /users/new        | new
  # POST    /users            | create
  # GET     /users/<:id>/edit | edit
  # PATCH   /users/<:id>      | update
  # DELETE  /users/<:id>      | delete
  resources :users
end