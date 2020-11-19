class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def genre
    str = params[:string]
    genre_array = Genre.where("name ILIKE ?", "%#{str}%")
    hash = {}
    genre_array.each do |genre|
      hash[genre.id] = genre.name
    end
    render json: hash
  end

  def actor
    str = params[:string]
    actor_array = Actor.where("fullname ILIKE ?", "%#{str}%")
    hash = {}
    actor_array.each do |actor|
      hash[actor.id] = actor.fullname
    end
    render json: hash
  end

  def director
    str = params[:string]
    director_array = Director.where("fullname ILIKE ?", "%#{str}%")
    hash = {}
    director_array.each do |director|
      hash[director.id] = director.fullname
    end
    render json: hash
  end
  
end
