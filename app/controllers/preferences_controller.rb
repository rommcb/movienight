class PreferencesController < ApplicationController
  def edit
  end

  def update
  end

  def make
    @token = session[:_csrf_token]
  end

  def save
    actors = params[:actor_pref].split(",")
    genres = params[:genre_pref].split(",")
    directors = params[:director_pref].split(",")
    duration = params[:duration].to_i

    actors.each do |actor_name|
      PreferencesActor.where(user_id: current_user.id).destroy_all
      actor_id = Actor.where(fullname: actor_name).first.id
      pa = PreferencesActor.new(user_id: current_user.id, actor_id:actor_id)
      pa.save!
    end

    genres.each do |genre_name|
      PreferencesGenre.where(user_id: current_user.id).destroy_all
      genre_id = Genre.where(name: genre_name).first.id
      pg = PreferencesGenre.new(user_id: current_user.id, genre_id:genre_id)
      pg.save!
    end

    directors.each do |director_name|
      PreferencesDirector.where(user_id: current_user.id).destroy_all
      director_id = Director.where(fullname: director_name).first.id
      pd = PreferencesDirector.new(user_id: current_user.id, director_id:director_id)
      pd.save!
    end

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
