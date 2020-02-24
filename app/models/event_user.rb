class EventUser < ApplicationRecord
	has_many :entry_tables
	belongs_to :event
	belongs_to :user
	belongs_to :part_table

	enum party_participate: { 不参加: 0, 参加: 1, 検討中: 2 }

	validates :party_participate, presence: true
end
