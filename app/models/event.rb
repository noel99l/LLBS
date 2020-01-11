class Event < ApplicationRecord
	has_many :musics, dependent: :destroy
	has_many :event_users, dependent: :destroy
	has_one :after_party, dependent: :destroy
end