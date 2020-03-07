class PartTable < ApplicationRecord
	has_many :event_users
	belongs_to :event

	validates :part_name, :uniqueness => {:scope => :event_id}
	validates :part_name, length: { in: 2..10 }
end
