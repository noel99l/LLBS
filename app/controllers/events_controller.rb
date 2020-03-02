class EventsController < ApplicationController

  def confirm
    @event_user = EventUser.new
    @event = Event.friendly.find(params[:event_id])
    @part_tables = PartTable.where(event_id: @event.id).order(:id)
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
     respond_to do |format|
      format.html
      format.csv do
        if params[:name] == "complete"
        musics_csv(@complete_musics, @parts)
        elsif params[:name] == "incomplete"
        musics_csv(@incomplete_musics, @parts)
        end
      end
    end
  end

  def musics_csv(musics, parts)
    require "csv"
    csv_data = CSV.generate(encoding: Encoding::SJIS) do |csv|

      header = %w(タイトル アーティスト名)
        parts.each do |part|
          header.push(part.part_name)
        end
      csv << header

      # body
      musics.each do |music|
        entry_tables = EntryTable.where(music_id: music.id)
        values = [
          music.title,
          music.artist
        ]
        entry_tables.each do |entry_table|
          values.push(entry_table.event_user&.user&.name)
        end
        csv << values
      end
    end
    @now = Time.current
    @event = Event.friendly.find(params[:id])
    send_data(csv_data, filename: "#{@event.friendly_id} #{@now}.csv")
  end

  def index
    now = Time.current
    @future_events = Event.where('date >= ?', now)
  	@past_events = Event.where('date < ?', now)
  end

  def timetable
    @event = Event.friendly.find(params[:event_id])
    @parts = Part.where(event_id: @event.id).order(:id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.where(part_id: @parts)
    @musics = Music.where(event_id: @event, establishment_count:0).order(:position)
  end

end