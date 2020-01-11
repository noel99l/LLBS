class Music < ApplicationRecord
	has_many :music_comments, dependent: :destroy
	has_many :entry_tables, dependent: :destroy
	belongs_to :event
end
