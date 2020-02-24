class CreatePartTables < ActiveRecord::Migration[5.2]
  def change
    create_table :part_tables do |t|
      t.integer :event_id, null: false
      t.string :part_name, null: false
      t.integer :count, null: false, default: 1
      t.boolean :observe, null: false
      t.timestamps
    end
  end
end
