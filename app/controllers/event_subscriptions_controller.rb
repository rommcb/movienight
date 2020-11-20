class EventSubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:destroy]

  def create
    _code(params[:event][:code])
  end

  def _code(code)
    event = Event.where(code: code).first
    if event == nil
      redirect_to(events_path("Error"))
    else
      if EventSubscription.where(user_id: current_user.id).length == 0
        event_sub = EventSubscription.new(owner: false, user_id: current_user.id, event_id: event.id)
        event_sub.save!
      end
      redirect_to("/events/#{event.id}") 
    end
  end

  def destroy
    @event = Event.find(@subscription.event_id)
    @subscription.destroy
    redirect_to events_path
  end

  private

  def set_subscription
    @subscription = EventSubscription.find(params[:id])
  end
end
