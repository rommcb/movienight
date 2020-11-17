class EventMovie < ApplicationRecord
  belongs_to :event
  has_one :movie
  has_many :reviews
end