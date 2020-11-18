class CreateSwipes < ActiveRecord::Migration[6.0]
  def change
    create_table :swipes do |t|
      t.string :edit
      t.string :update

      t.timestamps
    end
  end
end
