class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
    t.integer :event_id, null: false
	t.string :part_name, null: false
    t.timestamps

    validates :part_name,    length: { in: 2..10 }
    end
  end
end
