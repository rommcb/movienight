class CreateEvent < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :date_time, null: false
      t.text :description
      t.string :code, null: false
    end
  end
end
