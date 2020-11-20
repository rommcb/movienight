class AddStuffToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, default: ""
    add_column :users, :max_duration_pref, :integer, default: 600
  end
end
