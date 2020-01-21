class AddIndexEventFriendlyUrl < ActiveRecord::Migration[5.2]
  def change
  	add_index :events, :friendly_url, unique: true
  end
end
