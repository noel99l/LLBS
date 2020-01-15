class EntryTable < ApplicationRecord
	belongs_to :event_user, optional: true
	belongs_to :part
	belongs_to :music

	enum recruitment_status: { 募集中: 0, エントリー中: 1, 譲渡可: 2, 募集終了: 3 }
	enum requirement_status: { 必須: 0, 不要: 1, 任意: 2 }
end