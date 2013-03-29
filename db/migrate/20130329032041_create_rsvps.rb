class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :status
      t.integer :event_id
      t.integer :user_id
      t.integer :inviter_id

      t.timestamps
    end
    add_index :rsvps, :user_id
    add_index :rsvps, :event_id
    add_index :rsvps, [:user_id, :event_id], unique: true
  end
end
