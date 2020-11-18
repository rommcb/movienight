class EventMoviesController < ApplicationController
  def edit

    @movie = EventMovie.find(params[:id])
  end

  def update
    @movie = EventMovie.find(params[:id])
      if params[:commit] == "like"
      @movie.score += 1
      else
      @movie.score -= 1
      end
    @movie.save
  end
end
