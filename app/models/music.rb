class Music < ApplicationRecord
	has_many :music_comments, dependent: :destroy
	has_many :entry_tables, dependent: :destroy
	belongs_to :event
	belongs_to :user
	accepts_nested_attributes_for :entry_tables

	validates :title, presence: true
	validates :artist, presence: true
end