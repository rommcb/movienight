class Event < ApplicationRecord
  has_many :event_movies
  has_many :users, through: :event_subscriptions
end