class GenresAttribution < ApplicationRecord
  belongs_to :movie
  has_one :genre
end