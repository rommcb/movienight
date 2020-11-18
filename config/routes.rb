Rails.application.routes.draw do

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :events do
    resources :show_winner, only: [:index]
  end

  resources :event_subscriptions, only: [:create]
  resources :preferences, only: [:edit, :update]
  resources :reviews, only: [:create]
  resources :movies, only: [:index, :show]
  resources :event_movies, only: [:edit, :update]
  'post'

end
