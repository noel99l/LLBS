class EventUser < ApplicationRecord
	has_many :entry_tables, dependent: :destroy
	belongs_to :event
	belongs_to :user
end
