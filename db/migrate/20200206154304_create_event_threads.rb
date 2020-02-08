class CreateEventThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :event_threads do |t|
      t.integer :event_id, null: false
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
