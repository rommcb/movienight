class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    # _get_next(Event.find(1))
    @events = current_user.events

    # Event.joins(:event_subscriptions).where("user_id = #{current_user.id}")


  end

  def show
    @event_id = Event.find(params[:id])
    @movie = Movie.find(_get_next(@event_id))
     @owner = @event.users

  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.date_start = DateTime.now
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
    params.require(:event).permit(:name, :description, :date_end)
  end

  def _find_movie_like(event)
    tmp_movies_array = EventMovie.joins(:reviews).where("score > 0 AND user_id != #{current_user.id} AND event_id = #{event.id}")
    liked_movies = []

    tmp_movies_array.each do |movie|
      movie.score.times do
        liked_movies.push(movie.id)
      end
    end
    return liked_movies

  end

  def _find_pref_movies(n, event)
    pref_actors = current_user.actors
    pref_directors = current_user.preferences_directors
    pref_genres = current_user.genres

    # pref_actors = [Actor.find(4), Actor.find(5), Actor.find(6)]
    # pref_directors = [Director.find(2), Director.find(5)]
    # pref_genres = [Genre.find(2), Genre.find(3)]

    sql_header = "
    SELECT m.id FROM movies m
    JOIN castings c ON c.movie_id = m.id
    JOIN genres_attributions g ON g.movie_id = m.id
    WHERE\n"

    str_genres = ""
    pref_genres.each_with_index do |genre, i|
      if i == pref_genres.length - 1
        str_genres = "#{str_genres}g.genre_id = #{genre.id}"
      else
        str_genres = "#{str_genres}g.genre_id = #{genre.id} OR "
      end
    end

    str_actors = ""
    pref_actors.each_with_index do |actor, i|
      if i == pref_actors.length - 1
        str_actors = "#{str_actors}(c.actor_id = #{actor.id}"
        if str_genres != ""
          str_actors = "#{str_actors} AND (#{str_genres}))"
        else
          str_actors = "#{str_actors})"
        end
      else
        str_actors = "#{str_actors}(c.actor_id = #{actor.id}"
        if str_genres != ""
          str_actors = "#{str_actors} AND (#{str_genres}))\nOR"
        else
          str_actors = "#{str_actors})\n OR"
        end
      end
    end
    if pref_actors.length == 0
      str_actors = str_genres
    end

    str_directors = ""
    pref_directors.each_with_index do |director, i|
      if i == pref_directors.length - 1
        str_directors = "(\n#{str_directors} m.director_id = #{director.id}"
        if str_actors != ""
          str_directors = "#{str_directors} AND (\n #{str_actors}\n))"
        else
          str_directors = "#{str_directors})"
        end
      else
        str_directors = "#{str_directors} m.director_id = #{director.id}"
        if str_actors != ""
          str_directors = "#{str_directors} AND (\n #{str_actors}\n)) \n OR(\n"
        else
          str_directors = "#{str_directors}) \n OR(\n"
        end
      end
    end
    if str_directors == ""
      str_directors = str_actors
    end
    if str_genres == ""
      sql = _no_pref(n, event)
    else
      sql = "#{sql_header}#{str_directors}\n AND
      NOT EXISTS(
      SELECT * FROM reviews r
      JOIN event_movies v ON v.id = r.event_movie_id
      WHERE
      v.movie_id = m.id AND v.event_id = #{event.id}
      )
      GROUP BY m.id
      LIMIT #{n}"
    end


    movie_array = []
    query_array = ActiveRecord::Base.connection.execute(sql)
    query_array.each do |item|
      movie_array.push(item['id'])
    end
    if movie_array.length < n
      new_n = n - movie_array.length
      new_query_array = ActiveRecord::Base.connection.execute(_no_pref(new_n, event))
      new_query_array.each do |item|
        movie_array.push(item['id'])
      end
    end
    return movie_array
  end

  def _no_pref(n, event)
    "SELECT m.id FROM movies m
    WHERE
    NOT EXISTS(
      SELECT * FROM reviews r
      JOIN event_movies v ON v.id = r.event_movie_id
      WHERE
      v.movie_id = m.id AND v.event_id = #{event.id}
      )
      GROUP BY m.id
      LIMIT #{n}"
  end

  def _get_next(event)
    start_time = DateTime.now
    total_time = (event.date_end - event.date_start)/60
    time_remaining = (event.date_end - DateTime.now)/60.0
    ## number of liked movies in event_movies and not in review
    # x_values = EventMovie.joins(:reviews).where("score > 0 AND user_id = #{current_user.id} AND event_id = #{event.id}")
    arr1 = _find_movie_like(event)
    x = arr1.length

    n = EventSubscription.where(event_id: event.id).length
    r =  _number_of_randoms(x, time_remaining, total_time, n)
    arr2 = _find_pref_movies(r, event)
    movie_arr = arr1 + arr2
    return movie_arr.sample
    # arr = [] _find_movie_like()
    ## return a sample from that list
  end

  def _number_of_randoms(x, t, total_t, n, b = 1, a = 1)
    x.to_f

    val1 = x*t*b/total_t
    val2 = ((30.0-n)*a)/30.0

    val3 = val1 * val2
    return val3.ceil
  end

end
