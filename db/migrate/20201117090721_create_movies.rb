class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.references :director
      t.string :title, null: false
      t.text :synopsis, null: false
      t.integer :duration, null: false
      t.string :cover
      t.string :poster
    end
  end
end
