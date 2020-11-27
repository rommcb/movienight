class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy swipe]

  def index
    @events = current_user.events
    @code_event = Event.new
    @error_message = ""
    session[:_csrf_token]
    @error_message = "This code doesn't exist." if params[:format] == "Error"
  end

  def show
    @event_id = params[:id]
    @owner = @event.users
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.date_start = DateTime.now
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @event.update(event_params)
    if @event.save
      @event.save!
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def stop
    event = Event.find(params[:id])
    redirect_to(swipe_path(event.id)) && return unless event_stoppable?(event)

    event.update(closed: true)
    redirect_to(result_path(event.id))
  end

  def result
    @event = Event.find(params[:id])
    event_movies = EventMovie.where("event_id = #{@event.id} AND score > 0").order({ score: :desc })
    @winner = Movie.find(event_movies.first.movie_id)
    @fill = Movie.where("id != #{@winner.id}").order("RANDOM()")[0..98]
    @winner_pos = rand(1..97)
  end

  def restart
    raise
  end

  def destroy
    @event.destroy

    redirect_to events_path
  end

  def swipe
    @user_id = current_user.id
    @event_id = @event.id
  end

  private

  def event_stoppable?(event)
    event.event_movies.where("score > 0").present? &&
      current_user == event.owner
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date_end, :closed)
  end
end
