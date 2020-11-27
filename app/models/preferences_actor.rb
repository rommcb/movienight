class PreferencesActor < ApplicationRecord
  belongs_to :user
  belongs_to :actor
end
