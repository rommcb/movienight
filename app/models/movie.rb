class Movie < ApplicationRecord
  has_many :castings
  has_many :actors, through: :castings
  has_many :genres_attributions
  has_many :genres, through: :genres_attributions
end
