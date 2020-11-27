class Event < ApplicationRecord
  has_many :event_movies, dependent: :destroy
  has_many :event_subscriptions, dependent: :destroy
  has_many :users, through: :event_subscriptions
  has_many :reviews, through: :event_movies

  validate :expiration_date_cannot_be_in_the_past

  after_create_commit :create_subscription_and_code

  def owner
    event_subscriptions.find_by(owner: true)
  end

  private

  def create_subscription_and_code
    code = "#{id}123"
    save
    EventSubscription.create(owner: true, user: user, event: self)
  end

  def expiration_date_cannot_be_in_the_past
    errors.add(:date_end, "can't be in the past") if
          !date_end.blank? && (date_end < Date.today)
  end
end
