class CreateEventSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :event_subscriptions do |t|
      t.boolean :owner, null: false
      t.references :user, null: false
      t.references :event, null: false
    end
  end
end
