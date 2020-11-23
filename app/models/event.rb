class Event < ApplicationRecord
  has_many :event_movies, dependent: :destroy
  has_many :event_subscriptions, dependent: :destroy
  has_many :users, through: :event_subscriptions
  has_many :reviews, through: :event_movies
end