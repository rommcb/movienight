Rails.application.routes.draw do
  # get 'event_subscriptions/create'
  # get 'reviews/create'
  # get 'preferences/edit'
  # get 'preferences/update'
  # get 'movies/index'
  # get 'movies/show'
  # get 'movies/show_winner'
  # get 'events/index'
  # get 'events/new'
  # get 'events/create'
  # get 'events/show'
  # get 'events/edit'
  # get 'events/update'
  # get 'events/destroy'
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :event_subscriptions, only: [:create]
  resources :reviews, only: [:create]
  resources :preferences, only: [:edit, :update]
  resources :events
  resources :movies, only: [:index, :show]
  # otherxise, it doesn't appear in the routes.
  get 'movies/show_winner'


end
