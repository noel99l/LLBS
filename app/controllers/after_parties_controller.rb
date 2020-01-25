class AfterPartiesController < ApplicationController
  def show
  	@event = Event.friendly.find(params[:event_id])
  	@after_party = AfterParty.find_by(event_id: @event.id)
  	@event_users = EventUser.where(event_id: @after_party.event_id)
  	if user_signed_in? && EventUser.find_by(event_id: @after_party.event_id, user_id: current_user.id).presence
    	@event_current_user = EventUser.find_by(event_id: @after_party.event_id, user_id: current_user.id)
	end
  end
end