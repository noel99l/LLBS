class CreateEntryTables < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_tables do |t|
	t.integer :event_user_id
	t.integer :music_id, null: false
	t.integer :part_id, null: false
	t.integer :recruitment_status, null: false, defalut: 0
	t.integer :requirement_status, null: false
    t.timestamps
    end
  end
end
