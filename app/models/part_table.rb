class PartTable < ApplicationRecord
	has_many :event_users
	belongs_to :event

	validates :part_name, :uniqueness => {:scope => :event_id}
	enum observe: { 演奏参加: 0, 見学: 1}
end
