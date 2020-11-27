class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :swipe]

  def index
    @events = current_user.events
    @code_event = Event.new
    @error_message = ""
    session[:_csrf_token]
    if params[:format] == "Error"
      @error_message = "This code doesn't exist."
    end
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
      @event.code = "#{@event.id}123"
      @event.save
      subscription = EventSubscription.new(owner: true, user_id: current_user.id, event_id: @event.id)
      subscription.save
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
    if current_user.id == event.event_subscriptions.where(owner: true)[0].user.id
      if event_movies = EventMovie.where("event_id = #{event.id} AND score > 0").length == 0
        redirect_to(swipe_path(event.id))
      else
        redirect_to(result_path(event.id))
        event.closed = true
        event.save!
      end
    end
  end

  def result
    @event = Event.find(params[:id])
    event_movies = EventMovie.where("event_id = #{@event.id} AND score > 0").order({score: :desc})
    @winner = Movie.find(event_movies.first.movie_id)
    @fill = Movie.where('id > 0').order("RANDOM()")[0..98]
    # @fill = Movie.all[0..98]
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
    # @movie = Movie.find(_get_next(@event))
    # @event_movie = EventMovie.where("movie_id = #{@movie.id} AND event_id = #{@event.id}").first

    # if @event_movie.nil?
    #   @event_movie = EventMovie.new(movie_id: @movie.id, event_id:@event.id, score:0)
    #   @event_movie.save!
    # end

    @user_id = current_user.id
    @event_id = @event.id
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date_end, :closed)
  end
end
