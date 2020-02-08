class EventThreadComment < ApplicationRecord
	belongs_to :event_thread
	belongs_to :user

	validates :comment, presence: true
end
