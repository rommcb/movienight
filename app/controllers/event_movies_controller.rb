class EventMoviesController < ApplicationController
  def edit
    @event_movie = EventMovie.find(params[:id])
  end

  def update
    @event_movie = EventMovie.find(params[:id])
    @event_movie.score += 1
    @event_movie.save
  end
end
