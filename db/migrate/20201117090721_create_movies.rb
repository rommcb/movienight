class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.references :director
      t.string :title, null: false
      t.text :synopsis, null: false
    end
  end
end
