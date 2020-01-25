class AfterParty < ApplicationRecord
	belongs_to :event
	validates :party_place, presence: true
	validates :party_postalcode, format: { with: /\A[0-9]+\z/ }, length: { is: 7 }, presence: true
	validates :party_address, presence: true
	validates :party_overview, presence: true
	validates :party_fee, presence: true
end
