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

  # GET     /users            | index
  # GET     /users/<:id>      | show
  # GET     /users/new        | new
  # POST    /users            | create
  # GET     /users/<:id>/edit | edit
  # PATCH   /users/<:id>      | update
  # DELETE  /users/<:id>      | delete
  resources :users do
    # フォロー中、フォローワー
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]

  ######## API ########
  namespace :api do
    namespace :v1 do
      # users
      resources :users, only: [] do
        # showアクションを/users/current_userで接続できるように変更
        get :current_user, action: :show, on: :collection
      end

      # login, logout
      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
