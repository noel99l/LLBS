class AfterParty < ApplicationRecord
	has_one :event, dependent: :destroy
end
