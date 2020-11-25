class Event < ApplicationRecord
  has_many :event_movies, dependent: :destroy
  has_many :event_subscriptions, dependent: :destroy
  has_many :users, through: :event_subscriptions
  has_many :reviews, through: :event_movies

  validate :expiration_date_cannot_be_in_the_past,
  # :discount_cannot_be_greater_than_total_value

  def expiration_date_cannot_be_in_the_past
    errors.add(:date_end, "can't be in the past") if
      !date_end.blank? and date_end < Date.today
  end

  # def discount_cannot_be_greater_than_total_value
  #   errors.add(:discount, "can't be greater than total value") if
  #     discount > total_value
  # end
end
