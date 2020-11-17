class PreferencesGenre < ApplicationRecord
  belongs_to :user
  has_one :genre
end