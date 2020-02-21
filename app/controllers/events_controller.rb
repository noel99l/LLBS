class EventsController < ApplicationController

  def confirm
    @event_user = EventUser.new
    @event = Event.friendly.find(params[:event_id])
    @parts = Part.where(event_id: @event.id).order(:id)
    @after_party = AfterParty.find_by(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
  end

  def show
    @now = Time.current
  	@event = Event.friendly.find(params[:id])
  	@parts = Part.where(event_id: @event.id).order(:id)
    @event_users = EventUser.where(event_id: @event.id)
    @event_threads = EventThread.where(event_id: @event.id)
    @entry_tables = EntryTable.where(part_id: @parts)
    @complete_musics = Music.where(event_id: @event, establishment_count:0).order(:updated_at)
  	@incomplete_musics = Music.where("(event_id = ?) AND (establishment_count > ?)", @event, 0).order(:establishment_count)
  end

  def index
    now = Time.current
    @future_events = Event.where('date >= ?', now)
  	@past_events = Event.where('date < ?', now)
  end
end