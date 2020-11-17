class CreateReview < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false
      t.references :event_movie, null: false
    end
  end
end
