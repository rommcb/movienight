class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    _get_next(Event.find(1))
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
  end

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
    start_time = DateTime.now
    total_time = (event.date_end - event.date_start)/60
    time_remaining = (event.date_end - DateTime.now)/60.0
    ## number of liked movies in event_movies and not in review
    x_values = EventMovie.joins(:reviews).where("score > 0 AND user_id = #{current_user.id}")
    x = x_values.length
   
    n = EventSubscription.where(event_id: event.id).length
    r =  _number_of_randoms(x, time_remaining, total_time, n)
    arr = [] ## get the r movies from the db(from the preference function)
    ## put all liked movied in that arr list
    ## return a sample from that list
  end

  def _get_n_movie(n)

  end

  def _number_of_randoms(x, t, total_t, n, b = 1, a = 1)
    x.to_f
  
    val1 = x*t*b/total_t
    val2 = ((30.0-n)*a)/30.0
  
    val3 = val1 * val2
    return val3.ceil
  end

end
