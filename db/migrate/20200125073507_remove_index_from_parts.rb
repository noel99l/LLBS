class RemoveIndexFromParts < ActiveRecord::Migration[5.2]
  def change
  	remove_index :parts, [:event_id, :part_name]
  end
end
