class Admin::EventsController < ApplicationController
  def new
    @event = Event.new
    @part = @event.parts.build
    @after_party = @event.build_after_party
  end

  def create
    event = Event.new(event_params)
    event.save!
    redirect_to admin_events_path
  end

  def index
    @events= Event.all
  end

  def show
    @event = Event.friendly.find(params[:id])
    @parts = Part.where(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
    musics = Music.where(event_id: @event.id)
    @incomplete_musics = Music.where(event_id: @event.id, establishment_status:0)
    @complete_musics = Music.where(event_id: @event.id, establishment_status:1)
  end

  def edit
    @event = Event.friendly.find(params[:id])
    @parts = Part.where(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
    musics = Music.where(event_id: @event.id)
    @incomplete_musics = Music.where(event_id: @event.id, establishment_status:0)
    @complete_musics = Music.where(event_id: @event.id, establishment_status:1)
  end

  def update
    event = Event.friendly.find(params[:id])
    event.update(event_params)
    redirect_to admin_event_path(event)
  end

  def destroy
    event = Event.friendly.find(params[:id])
    event.destroy!
    redirect_to admin_events_path
  end

  private
  def event_params
    params.require(:event).permit(:after_party_id, :event_name, :friendly_url, :overview, :date, :meeting_time, :start_time, :finish_time,
      :place, :place_url, :performance_fee, :visit_fee, :image,
      parts_attributes: [:event_id, :part_name, :_destroy, :id],
      after_party_attributes: [:party_place, :party_postalcode, :party_address, :party_url, :party_fee, :party_overview, :_destroy])
  end
end
