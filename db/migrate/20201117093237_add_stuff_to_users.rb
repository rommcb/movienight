class AddStuffToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :max_duration_pref, :integer
  end
end
