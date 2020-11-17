class CreateCastings < ActiveRecord::Migration[6.0]
  def change
    create_table :castings do |t|
      t.references :actor, null: false
      t.references :movie, null: false
    end
  end
end
