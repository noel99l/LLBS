class AddLevelIdToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :exp, :integer, default: 0
  	add_column :users, :level_id, :integer, default: 1
  end
end
