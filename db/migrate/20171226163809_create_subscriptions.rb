class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :subscribed_to
      t.integer :subscribed_by

      t.timestamps
    end
  end
end
