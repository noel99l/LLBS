class EntryTable < ApplicationRecord
	belongs_to :event_user
	belongs_to :part
	belongs_to :music
end
