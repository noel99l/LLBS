class Event < ApplicationRecord
	has_many :musics, dependent: :destroy
	has_many :event_users, dependent: :destroy
	has_many :parts, dependent: :destroy
	has_one :after_party, dependent: :destroy
	attachment :image

	accepts_nested_attributes_for :parts, allow_destroy: true, update_only: true
	accepts_nested_attributes_for :after_party, allow_destroy: true, update_only: true

    validates :event_name, presence: true, uniqueness: true
	validates :friendly_url, length: { in: 3..20 },
                         uniqueness: true,
                         format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/ }
	validates :date, presence: true
	validates :meeting_time, presence: true
	validates :start_time, presence: true
	validates :finish_time, presence: true
	validates :place, presence: true
	validates :performance_fee, presence: true
	validates :visit_fee, presence: true


	include FriendlyId
  		friendly_id :friendly_url

  	def create_meeting_time
    	self.meeting_time = Time.zone.parse(self.date.to_s + " " + self.meeting_time.strftime('%H:%M:%S'))
    end

    def create_start_time
    	self.start_time = Time.zone.parse(self.date.to_s + " " + self.start_time.strftime('%H:%M:%S'))
    end

    def create_finish_time
    	self.finish_time = Time.zone.parse(self.date.to_s + " " + self.finish_time.strftime('%H:%M:%S'))
    end
end