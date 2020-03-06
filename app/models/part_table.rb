class PartTable < ApplicationRecord
	has_many :event_users
	belongs_to :event

	validates :part_name, :uniqueness => {:scope => :event_id}
end
