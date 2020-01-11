class Part < ApplicationRecord
	has_many :entry_tables, dependent: :destroy
	has_many :event_users, dependent: :destroy
	belongs_to :event
end
