class PreferencesActor < ApplicationRecord
  belongs_to :user
  has_one :actor
end