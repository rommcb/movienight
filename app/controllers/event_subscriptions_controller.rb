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
      if EventSubscription.where("user_id=#{current_user.id} AND event_id=#{event.id}").length == 0
        event_sub = EventSubscription.new(owner: false, user_id: current_user.id, event_id: event.id)
        event_sub.save!
      end
      redirect_to("/events/#{event.id}") 
    end
  end

  def destroy
      @event = Event.find(@subscription.event_id)
      user_id = @subscription.user_id
      sql = "
        select R.id from reviews R
        join event_movies EM on EM.id = R.event_movie_id 
        where
        R.user_id = #{user_id} and EM.event_id = #{@subscription.event_id} 
      "
      query_array = ActiveRecord::Base.connection.execute(sql)
      query_array.each do |item|
        Review.find(item['id']).destroy
      end
    
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

  def set_subscription
    @subscription = EventSubscription.find(params[:id])
  end
end
