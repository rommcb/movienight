class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :event_subscriptions, dependent: :destroy
  has_many :events, through: :event_subscriptions

  has_many :preferences_actors, dependent: :destroy
  has_many :actors, through: :preferences_actors

  has_many :preferences_directors, dependent: :destroy
  has_many :directors, through: :preferences_directors

  has_many :preferences_genres, dependent: :destroy
  has_many :genres, through: :preferences_genres

  has_many :reviews, dependent: :destroy
end
