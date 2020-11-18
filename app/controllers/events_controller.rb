class EventsController < ApplicationController
  def index
    _get_next(Event.find(1))
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
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
