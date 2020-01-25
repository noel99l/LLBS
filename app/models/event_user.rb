class EventUser < ApplicationRecord
	has_many :entry_tables
	belongs_to :event
	belongs_to :user
	belongs_to :part

	enum party_participate: { 不参加: 0, 参加: 1, 検討中: 2 }

	validates :part_id, presence: true
	validates :party_participate, presence: true
end
