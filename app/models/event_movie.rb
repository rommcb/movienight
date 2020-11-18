class EventMovie < ApplicationRecord
  belongs_to :event
  belongs_to :movie
  has_many :reviews
end