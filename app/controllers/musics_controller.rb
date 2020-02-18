class MusicsController < ApplicationController
  before_action :show_header, only: [:new, :show, :edit]
  def show_header
    @event = Event.friendly.find(params[:event_id])
    @event_users = EventUser.where(event_id: @event)
  end

  def new
    @event = Event.friendly.find(params[:event_id])
    @music = Music.new
    @entry_table = @music.entry_tables.build
    @parts = Part.where(event_id: @event.id).order(:id)
  end

  def show
    @now = Time.current
    @music = Music.find(params[:id])
    @entry_tables = EntryTable.where(music_id: @music)
    @music_comments = MusicComment.where(music_id: @music)
    @parts = Part.where(event_id: @event.id).order(:id)
    if EventUser.find_by(event_id: @event, user_id: current_user).presence
      @music_comment = MusicComment.new
    end
  end

  def create
    @music = Music.new(music_params)
      if @music.save
        calculate_level(5)
        flash[:success] = "#{@music.title}を追加しました！"
        redirect_to event_path(@music.event.friendly_url)
      else
        error =''
        @music.errors.full_messages.each do |message|
          error += message + '<br />'
        end
        @event = Event.friendly.find(params[:event_id])
        redirect_to new_event_music_path(@event), notice: error
      end
  end

  def edit
    @event = Event.friendly.find(params[:event_id])
    @music = Music.find(params[:id])
    @entry_table = @music.entry_tables.all
    @parts = Part.where(event_id: @event.id).order(:id)
  end

  def update
    @music = Music.find(params[:id])
    if @music.update(music_params)
      if @music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count == 0 #もしもエントリーテーブル必須でユーザーidが入っていないレコードが１つもないならば
            @music.establishment_status = "成立"
      else @music.establishment_status = "募集中"
      end
      @music.save
      flash[:success] = "#{@music.title}を更新しました！"
      redirect_to event_path(@music.event.friendly_url)
    else
      @event = Event.friendly.find(params[:event_id])
      @entry_table = @music.entry_tables.all
      @parts = Part.where(event_id: @event.id).order(:id)
      render "edit"
    end
  end

  def destroy
    music = Music.find(params[:id])
    music.destroy
    calculate_level(-5)
    flash[:danger] = "#{music.title}を削除しました！"
    redirect_to event_path(music.event.friendly_url)
  end

  def calculate_level(exp)
    if exp < 0
      current_user.level_up?(exp)
      flash[:info] = "楽曲削除 #{exp.to_i}pt"
    elsif current_user.level_up?(exp)
      flash[:info] = "楽曲追加 #{exp.to_i}pt Get! Level UP!!"
    else
      flash[:info] = "楽曲追加 #{exp.to_i}pt Get!"
    end
  end

  private
  def music_params
    params.require(:music).permit(:event_id, :title, :artist, :music_url, :remarks, :user_id,
     entry_tables_attributes: [:id, :event_user_id, :music_id, :part_id, :recruitment_status, :requirement_status])
  end
end