class PreferencesController < ApplicationController
  def edit
  end

  def update
  end

  def make
    @token = session[:_csrf_token]
    @actor_str = ""
    @director_str = ""
    @genre_str = ""
    current_user.actors.each do |actor|
      @actor_str = "#{@actor_str},#{actor.fullname}"
    end
    current_user.genres.each do |genre|
      @genre_str = "#{@genre_str},#{genre.name}"
    end
    current_user.directors.each do |director|
      @director_str = "#{@director_str},#{director.fullname}"
    end

  end



  def save
    actors = params[:actor_list].split(",")
    if actors.length != 0
      PreferencesActor.where(user_id: current_user.id).destroy_all
      actors = actors[1..]
      actors.each do |actor_name|
        actor_id = Actor.where(fullname: actor_name).first.id
        pa = PreferencesActor.new(user_id: current_user.id, actor_id:actor_id)
        pa.save!
      end
    else
      PreferencesActor.where(user_id: current_user.id).destroy_all
    end

    genres = params[:genre_list].split(",")
    if genres.length != 0
      PreferencesGenre.where(user_id: current_user.id).destroy_all
      genres = genres[1..]
      genres.each do |genre_name|
        genre_id = Genre.where(name: genre_name).first.id
        pg = PreferencesGenre.new(user_id: current_user.id, genre_id:genre_id)
        pg.save!
      end
    else
      PreferencesGenre.where(user_id: current_user.id).destroy_all
    end

    directors = params[:director_list].split(",")
    if directors.length != 0
      PreferencesDirector.where(user_id: current_user.id).destroy_all
      directors = directors[1..]
      directors.each do |director_name|
        director_id = Director.where(fullname: director_name).first.id
        pd = PreferencesDirector.new(user_id: current_user.id, director_id:director_id)
        pd.save!
      end
    else
      PreferencesDirector.where(user_id: current_user.id).destroy_all
    end
    duration = params[:duration].to_i


    if duration == 0
       current_user.max_duration_pref = 600
       current_user.save!
    else
      current_user.max_duration_pref = duration
      current_user.save!
    end

    redirect_to(events_path)

  end
end
