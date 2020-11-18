class CreatePreferencesActors < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences_actors do |t|
      t.references :user, null: false
      t.references :actor, null: false
    end
  end
end
