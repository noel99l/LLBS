class CreateLyrics < ActiveRecord::Migration[5.2]
  def change
    create_table :lyrics do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :artist, null: false
      t.text :lyric, null: false
      t.timestamps
    end
  end
end
