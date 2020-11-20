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
  
end
