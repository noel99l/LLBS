class Part < ApplicationRecord
	has_many :entry_tables, dependent: :destroy
	has_many :event_users
	belongs_to :event

	validates :part_name, length: { in: 2..10 }
end
