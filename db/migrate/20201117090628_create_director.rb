class CreateDirector < ActiveRecord::Migration[6.0]
  def change
    create_table :directors do |t|
      t.string :fullname, null: false
    end
  end
end
