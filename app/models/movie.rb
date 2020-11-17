class Movie < ApplicationRecord
  has_one :director
  has_many :actors, through: :castings
  has_many :genres, through: :genres_attributions
end