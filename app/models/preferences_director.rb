class PreferencesDirector < ApplicationRecord
  belongs_to :user
  has_one :director
end