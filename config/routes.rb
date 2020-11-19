Rails.application.routes.draw do


  # get '/user' => "", :as => :user_root

  
  

  devise_scope :user do 
    authenticated :user do
      root 'events#index', as: :authenticated_root 
    end 
    unauthenticated do 
      root to: 'pages#home', as: :unauthenticated_root 
    end 
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :events do
    resources :show_winner, only: [:index]
  end

  resources :event_subscriptions, only: [:create, :destroy]
  resources :preferences, only: [:edit, :update]
  resources :reviews, only: [:create]
  resources :movies, only: [:index, :show]
  resources :event_movies, only: [:edit, :update]

  get 'events/swipe/:id', to: 'events#swipe', as: :swipe

  get 'api/genre/:string', to: 'pages#genre'
  get 'api/actor/:string', to: 'pages#actor'
  get 'api/director/:string', to: 'pages#director'

end
