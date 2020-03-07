class Admin::EventsController < AdminController
  def new
    @event = Event.new
    # cocoonでデフォルト３つ表示させるために3回作成
    3.times {@event.part_tables.build}
    # has_oneの場合のbuildはは少し表記が変わる
    @after_party = @event.build_after_party
  end

  def new_confirm
    @event = Event.new(event_params)
    render :new if @event.invalid?
    #eventモデルのcreate_partメソッドを呼び出し、パートを作成
    @event.create_part
    # チェックが入っているときに見学パートテーブル作成
    if params[:event][:observe] == '1'
      part_table = @event.part_tables.build
      part_table.part_name = "見学"
      part_table.event_id = @event.id
      part_table.observe = "見学"
    end
  end

  def create
    @event = Event.new(event_params)
    @event.create_meeting_time
    @event.create_start_time
    @event.create_finish_time
    if @event.save
      flash[:success] = "#{@event.event_name}を新たに作成しました！"
      redirect_to admin_events_path
    else
      @part = @event.parts.build
      @after_party = @event.build_after_party
      render 'new'
    end
  end

  def index
    @events= Event.all
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

  def edit
    @event = Event.friendly.find(params[:id])
    @parts = Part.where(event_id: @event.id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
    musics = Music.where(event_id: @event.id)
    @incomplete_musics = Music.where(event_id: @event.id, establishment_status:0)
    @complete_musics = Music.where(event_id: @event.id, establishment_status:1)
  end

  def edit_confirm
    @event = Event.friendly.find(params[:event_id])
    @event.attributes = event_params
    render :edit if @event.invalid?
  end

  def update
    event = Event.friendly.find(params[:id])
    event.update(event_params)
    event.create_meeting_time
    event.create_start_time
    event.create_finish_time
    event.save(event_params)
    flash[:success] = "#{event.event_name}を更新しました！"
    redirect_to admin_events_path(event)
  end

  def destroy
    event = Event.friendly.find(params[:id])
    if event.destroy
    flash[:danger] = "#{event.event_name}を削除しました！"
    redirect_to admin_events_path
    else
      @events= Event.all
      render 'index'
    end
  end

  def timetable
    @event = Event.friendly.find(params[:event_id])
    @parts = Part.where(event_id: @event.id).order(:id)
    @event_users = EventUser.where(event_id: @event.id)
    @entry_tables = EntryTable.where(part_id: @parts)
    @musics = Music.where(event_id: @event, establishment_count:0).order(:position)
  end

  def sort
    event = Event.friendly.find(params[:event_id])
    music = event.musics.find_by(event_id: event, establishment_count: 0, position: params[:from].to_i + 1)
    music.insert_at(params[:to].to_i + 1)
    head :ok
  end

  def timetable_releace
    event = Event.friendly.find(params[:event_id])
    if event.timetable_releace == true
      event.timetable_releace = false
    elsif event.timetable_releace == false
      event.timetable_releace = true
    end
    event.save
    redirect_back(fallback_location: admin_event_timetable_path(event.friendly_url))
  end

  private
  def event_params
    params.require(:event).permit(:after_party_id, :event_name, :friendly_url, :overview, :date,
      :meeting_time, :start_time, :finish_time, :entry_start_time, :entry_finish_time,
      :place, :place_url, :performance_fee, :visit_fee, :image, :remote_image_url,:releace_flag, :timetable_releace,
      check_val: [:observe],
      parts_attributes: [:event_id, :part_name, :_destroy, :id],
      part_tables_attributes: [:event_id, :part_name, :count, :observe, :id, :_destroy],
      after_party_attributes: [:party_place, :party_postalcode, :party_address, :party_url, :party_fee, :party_overview, :_destroy])
  end
end
