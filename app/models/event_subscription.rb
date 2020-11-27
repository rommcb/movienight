class EventSubscription < ApplicationRecord
  belongs_to :event
  belongs_to :user
  before_destroy :destroy_reviews

  def destroy_reviews
    Review.where(user: user, event: event).destroy_all
  end
end
