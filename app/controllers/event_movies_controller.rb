class EventMoviesController < ApplicationController
  def edit
    @movie = EventMovie.find(params[:id])
  end
end
