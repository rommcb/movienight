class CreatePreferencesDirectors < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences_directors do |t|
      t.references :user, null: false
      t.references :director, null: false
    end
  end
end
