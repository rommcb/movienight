class CreateGenresAttributions < ActiveRecord::Migration[6.0]
  def change
    create_table :genres_attributions do |t|
      t.references :genre, null: false
      t.references :movie, null: false
    end
  end
end
