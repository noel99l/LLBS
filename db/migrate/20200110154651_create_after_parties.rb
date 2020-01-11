class CreateAfterParties < ActiveRecord::Migration[5.2]
  def change
    create_table :after_parties do |t|
    t.integer :event_id , null: false
    t.string :party_place, null: false
	t.integer :party_postalcode
	t.string :party_address
	t.text :party_overview, null: false
	t.integer :party_fee, null: false
	t.string :party_url
    t.timestamps
    end
  end
end
