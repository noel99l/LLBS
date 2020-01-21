class AddIndexEntryTableMusicId < ActiveRecord::Migration[5.2]
  def change
  	add_index :entry_tables, [:music_id, :part_id], unique: true
  	add_index :event_users, [:event_id, :user_id], unique: true
  	add_index :parts, [:event_id, :part_name], unique: true
  	add_index :events, :event_name, unique: true
  	add_index :users, :name, unique: true
  end
end
