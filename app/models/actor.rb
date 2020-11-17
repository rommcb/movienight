class Actor < ApplicationRecord
  has_many :movies, through: :castings
  validates :fullname, presence: true
  validates :fullname, uniqueness: true
end