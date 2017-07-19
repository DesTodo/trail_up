Rails.application.routes.draw do
  root 'landing#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboards#show'
  get '/directions', to: 'directions#index'


  get '/auth/fitbit/callback', to: 'fitbit#login'
  resources :fitbit, only: [:index, :show]

  get '/events/status', to: 'events#status'



  namespace :api do
    namespace :trails do
      resources :search, only: [:index]
      resources :names, only: [:index]
    end
    resources :fitbit_json, only: [:index]
    resources :trails, only: [:index]
  end


  namespace :trails do
   resources :search, only: [:index]
   resources :select, only: [:index, :new]
  end

  namespace :admin do
    get '/', to: 'landing#index'
    resources :trails
    resources :users, only: [:index, :update, :destroy]
    resources :events
  end

  namespace :events do
    resources :search, only: [:index, :new]
    resources :user_status, only: [:update]
    get '/update-status', to: 'event_status#index'
  end


  resources :users, only: [:create, :show, :edit, :update]
  resources :trails
  resources :pictures
  resources :events, only: [:index, :new, :create, :show, :destroy, :edit, :update]
end
