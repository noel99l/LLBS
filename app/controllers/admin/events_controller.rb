class Admin::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
  end

  def index
    @events= Event.all
  end

  def show
    @event = Event.find(params[:id])
    @parts = Part.where(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
    musics = Music.where(event_id: @event.id)
    @incomplete_musics = Music.where(event_id: @event.id, establishment_status:0)
    @complete_musics = Music.where(event_id: @event.id, establishment_status:1)
  end

  def edit
  end

  def update
  end

  def destroy #消せない
    event = Event.find(params[:id])
    event.destroy
    redirect_to root_path
  end

  private
  def event_params
    params.require(:event).permit(:after_party_id, :event_name, :friendly_url, :overview, :date, :meeting_time, :start_time, :finish_time,
      :place, :place_url, :performance_fee, :visit_fee, :image)
  end
end
