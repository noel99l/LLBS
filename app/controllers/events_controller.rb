class EventsController < ApplicationController

  def confirm
    @event_user = EventUser.new
    @event = Event.find(params[:event_id])
    @parts = Part.where(event_id: @event.id)
    @after_party = AfterParty.find_by(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
  end

  def show
  	@event = Event.find(params[:id])
  	@parts = Part.where(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
    @incomplete_musics = Music.where(event_id: @event.id, establishment_status:0)
  	@complete_musics = Music.where(event_id: @event.id, establishment_status:1)
  end

  def index
  	@events= Event.all
  end
end