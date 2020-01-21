class Event < ApplicationRecord
	has_many :musics, dependent: :destroy
	has_many :event_users, dependent: :destroy
	has_many :parts, dependent: :destroy
	has_one :after_party, dependent: :destroy
	attachment :image

	accepts_nested_attributes_for :parts, allow_destroy: true, update_only: true
	accepts_nested_attributes_for :after_party, allow_destroy: true, update_only: true

	validates :friendly_url, length: { in: 3..20 },
                         uniqueness: true,
                         format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/ }


	include FriendlyId
  		friendly_id :friendly_url
end