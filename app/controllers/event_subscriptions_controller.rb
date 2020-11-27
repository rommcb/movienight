class EventSubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]

  def create
    event_code = params[:event][:code]
    event = Event.find_by(code: event_code)

    redirect_to(events_path("Error")) && return if event.nil?

    create_subscription(event)
    redirect_to events_path
  end

  def destroy
    @subscription.destroy
    redirect_to events_path
  end

  def self_destroy
    @event = Event.find(params[:id])
    @subscription = EventSubscription.where(user_id: current_user.id, event_id: @event.id)
    @subscription.first.destroy
    redirect_to events_path
  end

  private

  def create_subscription(event)
    return if current_user.events.find(id: event.id)

    current_user.event_subscriptions.create(owner: false, event: event)
  end

  def set_subscription
    @subscription = EventSubscription.find(params[:id])
  end
end
