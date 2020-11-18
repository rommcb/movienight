class EventSubscriptionsController < ApplicationController
  def create
    _code(params[:event][:code])
  end

  def _code(code)
    event = Event.where(code: code).first
    if event == nil
      pp "Wrong code"
    else
      if EventSubscription.where(user_id: current_user.id).length == 0
        event_sub = EventSubscription.new(owner: false, user_id: current_user.id, event_id: event.id)
        event_sub.save!
      end
      redirect_to(events_path(15)) ## should redirect to the event that was subscribed to
    end
  end
end
