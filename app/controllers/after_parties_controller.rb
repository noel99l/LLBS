class AfterPartiesController < ApplicationController
  def show
  	@after_party = AfterParty.find(params[:event_id])
  	@event_users = EventUser.where(event_id: @after_party.event_id)
    @event_user = EventUser.find_by(event_id: @after_party.event_id, user_id: current_user.id)
  end
end