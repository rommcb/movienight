class AddMovieLikedToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :movie_liked, :boolean
  end
end
