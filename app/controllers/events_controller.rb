class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all #we need to select only the events belonging the user
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      @event.code = "123123"
      @event.save
      subscription = EventSubscription.new(owner: true, user_id: current_user.id, event_id: @event.id )
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

    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy

    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :date_time)

  def find_movie_like
    # what we want is  an array of movies wih score > 0

    # get the score in event_movies and sort the score > 0
    # @array_score = Event_movies.select { |movie| movie.score.positive? }
    # @array_score = Event_movies.where(:score.positive?)
    # store them into an array as an array of object of movies
    @array_score = EventMovie.where("score.positive?")

    # return the array of object

  end


  def _get_next(event)
    total_time = event.date_end - event.date_start
    time_remaining = (event.date_end - Date.today)/60
    x = ## number of liked movies in reviews table
    n = ## number of people in this event from 

  end


  def _number_of_randoms(x, t, total_t, n, b = 1, a = 1)
    x.to_f
  
    val1 = x*t*b/total_t
    val2 = ((30.0-n)*a)/30.0
  
  
    val3 = val1 * val2
    return val3.round()

  end

end
