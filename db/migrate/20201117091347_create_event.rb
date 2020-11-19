class CreateEvent < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :date_end, null: false
      t.datetime :date_start, null: false
      t.text :description
      t.string :code
      t.boolean :closed, null: :false, default: false
    end
  end
end
