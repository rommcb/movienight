class Genre < ApplicationRecord
  has_many :movies, through: :genres_attributions
  validates :name, presence: true
  validates :name, uniqueness: true
end
