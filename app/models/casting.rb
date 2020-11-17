class Casting < ApplicationRecord
  belongs_to :movie
  has_one :actor
end