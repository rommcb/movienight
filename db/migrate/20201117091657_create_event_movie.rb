class CreateEventMovie < ActiveRecord::Migration[6.0]
  def change
    create_table :event_movies do |t|
      t.references :movie, null: false
      t.references :event, null: false
      t.integer :score, default: 0
    end
  end
end
