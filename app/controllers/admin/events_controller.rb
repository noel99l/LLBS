class Admin::EventsController < AdminController
  def new
    @event = Event.new
    @part = @event.parts.build
    @after_party = @event.build_after_party
  end

  def new_confirm
    @event = Event.new(event_params)
    render :new if @event.invalid?
  end

  def create
    @event = Event.new(event_params)
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

  def edit_confirm
    @event = Event.friendly.find(params[:event_id])
    @event.attributes = event_params
    render :edit if @event.invalid?
  end

  def update
    event = Event.friendly.find(params[:id])
    event.update(event_params)
    flash[:success] = "#{event.event_name}を更新しました！"
    redirect_to admin_event_path(event)
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

  private
  def event_params
    params.require(:event).permit(:after_party_id, :event_name, :friendly_url, :overview, :date,
      :meeting_time, :start_time, :finish_time, :entry_start_time, :entry_finish_time,
      :place, :place_url, :performance_fee, :visit_fee, :image, :remote_image_url,
      parts_attributes: [:event_id, :part_name, :_destroy, :id],
      after_party_attributes: [:party_place, :party_postalcode, :party_address, :party_url, :party_fee, :party_overview, :_destroy])
  end
end
