class EventSubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]

  def create
  end

  def destroy
    @event = Event.find(@subscription.event_id)
    @subscription.destroy
    redirect_to edit_event_path(@event)
  end

  private

  def set_subscription
    @subscription = EventSubscription.find(params[:id])
  end

end
