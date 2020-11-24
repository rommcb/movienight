class EventMoviesController < ApplicationController
  def edit

    @movie = EventMovie.find(params[:id])
  end

  # def update
  #   event_movie = EventMovie.find(params[:event_movie][:id])
  #   if params[:like] != nil
  #     event_movie.score += 1
  #     event_movie.save!
  #     # review = Review.new(event_movie_id: event_movie.id, user_id:current_user.id; movie_liked: true)
  #     # review.save!
  #     # review.movie_liked = true
  #   else
  #     # review = Review.new(event_movie_id: event_movie.id, user_id:current_user.id)
  #     # review.save!
  #     # review.movie_liked = false
  #   end
  #   # review.save!
  #   redirect_to(swipe_path(event_movie.event_id))
  # end

end
