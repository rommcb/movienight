class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
    return
  end

  def home
  end

  def genre
    str = params[:string]
    genre_array = Genre.where("name ILIKE ?", "%#{str}%")
    hash = {}
    genre_array.each do |genre|
      hash[genre.id] = genre.name
    end
    cors_set_access_control_headers
    render json: hash
  end

  def actor
    str = params[:string]
    actor_array = Actor.where("fullname ILIKE ?", "%#{str}%")
    hash = {}
    actor_array.each do |actor|
      hash[actor.id] = actor.fullname
    end
    cors_set_access_control_headers
    render json: hash
  end

  def director
    str = params[:string]
    director_array = Director.where("fullname ILIKE ?", "%#{str}%")
    hash = {}
    director_array.each do |director|
      hash[director.id] = director.fullname
    end
    cors_set_access_control_headers
    render json: hash
  end

  def review
    str = params[:string].split(",")
    user_id = str[0].to_i
    event_movie_id = str[1].to_i
    liked = str[2].to_i

    event_movie = EventMovie.find(event_movie_id)
    if liked == 1
      event_movie.score += 1
      event_movie.save!
      review = Review.new(event_movie_id: event_movie.id, user_id:current_user.id, movie_liked: true)
      review.save!
    else 
      review = Review.new(event_movie_id: event_movie.id, user_id:current_user.id, movie_liked: false)
      review.save! 
    end

    hash = {}
    hash[0] = "Succes"
    cors_set_access_control_headers
    render json: hash
  end

  def movie
    str = params[:string].split(",")
    user_id = str[0].to_i
    event_id = str[1].to_i
    c_user = User.find(user_id)
    event = Event.find(event_id)
    mov = _get_next(event, c_user)
    @movie = Movie.find(mov)


    @event_movie = EventMovie.where("movie_id = #{@movie.id} AND event_id = #{event.id}").first
  
    if @event_movie.nil?
      @event_movie = EventMovie.new(movie_id: @movie.id, event_id:event.id, score:0)
      @event_movie.save!
    end
    hash = {}
    hash['id'] = @event_movie.id
    hash['title'] = @movie.title
    hash['director'] = Director.find(@movie.director_id).fullname
    hash['actors'] = []
    @movie.actors.each do |item|
      hash['actors'].push(item.fullname)
    end
    hash['actors'] = hash['actors'].join(', ')
    hash['synopsis'] = @movie.synopsis
    hash['cover'] = @movie.cover

    event = Event.find(event_id)
    if(event.closed == true)
      hash['closed'] = 1
    else 
      hash['closed'] = 0
    end
    c_arr = []
    users = event.users
    users.each do |user|
      u_id = user.id
      count = event.reviews.where(user_id: u_id, movie_liked: true).count
      c_arr.push([u_id, count, user.username])
    end
    hash['count'] = c_arr
    hash['matches'] = event.event_movies.where(score: event.users.count ).count
    hash['poster'] = @movie.poster
    
    cors_set_access_control_headers
    render json: hash
  end

  def _find_movie_like(event, c_user)
    sql = "select EM.id

    from   event_movies EM
    
    join movies M ON M.id=EM.movie_id AND EM.event_id=#{event.id}
    left join reviews R ON R.event_movie_id = EM.id AND R.user_id=#{c_user.id} 
    
    where EM.score > 0 and R.id is null"

    query_array = ActiveRecord::Base.connection.execute(sql)
    pp query_array
    liked_movies = []

    query_array.each do |item|
      em = EventMovie.find(item['id'])
      em.score.times do
        movie_id = em.movie.id
        liked_movies.push(movie_id)
      end
    end
    return liked_movies
  end

  def _find_pref_movies(n, event, c_user)
    pref_actors = c_user.actors
    pref_directors = c_user.preferences_directors
    pref_genres = c_user.genres
    max_duration = c_user.max_duration_pref

    sql_header = "
    SELECT m.id FROM movies m
    JOIN castings c ON c.movie_id = m.id
    JOIN genres_attributions g ON g.movie_id = m.id
    left join event_movies EM ON EM.movie_id=m.id AND EM.event_id=#{event.id}
    left join reviews R ON R.event_movie_id = EM.id AND user_id=#{c_user.id}
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
    if str_directors == ""
      sql = _no_pref(n, event, c_user)
    else
      sql = "#{sql_header}#{str_directors}\n AND
      R.id is null
      AND
      EM.score = 0
      AND
      m.duration < #{c_user.max_duration_pref}
      GROUP BY m.id
      ORDER BY random()
      LIMIT #{n}"
    end
  
    movie_array = []
    query_array = ActiveRecord::Base.connection.execute(sql)
    query_array.each do |item|
      movie_array.push(item['id'])
    end
    if movie_array.length < n
      new_n = n - movie_array.length
      new_query_array = ActiveRecord::Base.connection.execute(_no_pref(new_n, event, c_user))
      new_query_array.each do |item|
        movie_array.push(item['id'])
      end
    end
    return movie_array
  end

  def _no_pref(n, event, c_user)
    "SELECT m.id FROM movies M
    left join event_movies EM ON EM.movie_id=M.id AND EM.event_id=#{event.id}
    left join reviews R ON R.event_movie_id = EM.id AND user_id=#{c_user.id}
    WHERE
    ((R.id is null AND EM.score = 0) OR EM.id is null)
    AND
    m.duration < #{c_user.max_duration_pref}
    GROUP BY m.id
    ORDER BY random()
    LIMIT #{n}"
  end

  def _get_next(event, c_user)
    start_time = DateTime.now
    total_time = (event.date_end - event.date_start)/60
    time_remaining = (event.date_end - DateTime.now)/60.0
    ## number of liked movies in event_movies and not in review
    # x_values = EventMovie.joins(:reviews).where("score > 0 AND user_id = #{c_user.id} AND event_id = #{event.id}")
    arr1 = _find_movie_like(event, c_user)
    x = arr1.length

    n = EventSubscription.where(event_id: event.id).length
    r =  _number_of_randoms(x, time_remaining, total_time, n)
    arr2 = _find_pref_movies(r, event, c_user)
    movie_arr = arr1 + arr2
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp arr1
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp arr2
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    # pp "++++++++++++++++++++++++++++++++++++++++++++++++++++"
    if movie_arr.length == 0
      return 1
    end
    return movie_arr.sample
  end

  def _number_of_randoms(x, t, total_t, n, b = 1, a = 1)
    if x == 0
      x = 1.0
    end
    x.to_f

    val1 = x*t*b/total_t
    val2 = ((30.0-n)*a)/30.0

    val3 = val1 * val2
    return val3.ceil
  end

  
end
