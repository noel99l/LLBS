class CreateEventThreadComments < ActiveRecord::Migration[5.2]
  def change
    create_table :event_thread_comments do |t|
    t.integer :event_thread_id, null: false
    t.integer :user_id, null: false
  	t.text :comment, null: false
  	t.decimal :score, precision: 5, scale: 3
  	t.timestamps
    end
  end
end
