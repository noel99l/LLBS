class MusicComment < ApplicationRecord
	belongs_to :user
	belongs_to :music
	validates :comment, presence: true
end
