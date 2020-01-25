class AddColumnMusics < ActiveRecord::Migration[5.2]
  def change
  	add_column :musics, :user_id, :integer
  end
end
