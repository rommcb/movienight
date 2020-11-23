class Director < ApplicationRecord
  validates :fullname, presence: true
  validates :fullname, uniqueness: true
end