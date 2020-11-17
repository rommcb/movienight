class EventsController < ApplicationController
  def index
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

  def find_movie_like
    # what we want is  an array of movies wih score > 0

    # get the score in event_movies and sort the score > 0
    # @array_score = Event_movies.select { |movie| movie.score.positive? }
    # @array_score = Event_movies.where(:score.positive?)
    # store them into an array as an array of object of movies
    @array_score = EventMovie.where("score.positive?")

    # return the array of object

  end
end
