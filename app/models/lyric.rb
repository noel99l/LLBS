class Lyric < ApplicationRecord
	has_many :musics
	belongs_to :user
end