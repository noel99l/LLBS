class CreateMusics < ActiveRecord::Migration[5.2]
  def change
    create_table :musics do |t|
	t.integer :event_id, null: false
	t.string :title, null: false
	t.string :artist, null: false
	t.string :music_url
	t.integer :establishment_status, null: false, default: 0
	t.text :remarks
	t.timestamps
    end
  end
end