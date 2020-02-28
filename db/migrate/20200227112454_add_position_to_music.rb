class AddPositionToMusic < ActiveRecord::Migration[5.2]
  def change
    add_column :musics, :position, :integer
  end
end
