class Music < ApplicationRecord
	has_many :music_comments, dependent: :destroy
	has_many :entry_tables, dependent: :destroy
	belongs_to :event
	accepts_nested_attributes_for :entry_tables
	enum establishment_status: { 募集中: 0, 成立: 1, 譲渡可: 2, 募集終了: 3 }
end