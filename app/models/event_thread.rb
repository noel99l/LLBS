class EventThread < ApplicationRecord
	has_many :event_thread_comments, dependent: :destroy
	belongs_to :event
	belongs_to :user

	validates :title, presence: true
	validates :body, presence: true
end
