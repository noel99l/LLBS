class CreateEntryTables < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_tables do |t|
	t.integer :event_user_id, null: false
	t.integer :music_id, null: false
	t.integer :part_id, null: false
	t.integer :status, null: false, defalut: 0
    t.timestamps
    end
  end
end
