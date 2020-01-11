class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
    t.integer :after_party_id, null: false
    t.string :event_name, null: false
    t.string :friendly_url, null: false
	t.text :overview, null: false
	t.date :date, null: false
	t.time :meeting_time, null: false
	t.time :start_time, null: false
	t.time :finish_time, null: false
	t.string :place, null: false
	t.string :place_url
	t.integer :performance_fee
	t.integer :visit_fee
	t.string :image
  	t.timestamps
    end
  end
end
