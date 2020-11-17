class Director < ApplicationRecord
  validates :fullname, presence: true
  has_many :movies
  validates :fullname, uniqueness: true
end