class MusicsController < ApplicationController
  before_action :show_header, only: [:new, :show, :edit, :lyric]
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
    @music.establishment_count = @music.event.parts.count
      if @music.save
        @music.establishment_count = @music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count
        @music.save
        calculate_level(5)
        flash[:success] = "#{@music.title}を追加しました！"
        redirect_to event_music_path(@music.event.friendly_url, @music)
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
      @music.establishment_count = @music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count
      @music.save
      flash[:success] = "#{@music.title}を更新しました！"
      redirect_to event_music_path(@music.event.friendly_url, @music)
    else
      @event = Event.friendly.find(params[:event_id])
      @entry_table = @music.entry_tables.all
      @parts = Part.where(event_id: @event.id).order(:id)
      render "edit"
    end
  end

  def lyric
    @music = Music.find(params[:music_id])
    @lyric = Lyric.new
    @lyrics = Lyric.where(title: @music.title, artist: @music.artist)
  end

  def create_lyric
    music = Music.find(params[:music_id])
    lyric = Lyric.new(lyric_params)
    lyric.save
    music.lyric_id = Lyric.last.id
    music.save
    calculate_level(10)
    flash[:success] = "#{music.title}の歌詞分けを新規登録しました！"
    redirect_to event_music_path(music.event.friendly_url, music)
  end

  def select_lyric
    music = Music.find(params[:music_id])
    music.update(music_params)
    flash[:success] = "#{music.title}の歌詞分けを登録しました！"
    redirect_to event_music_path(music.event.friendly_url, music)
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
    params.require(:music).permit(:event_id, :title, :artist, :music_url, :remarks, :user_id, :lyric_id,
     entry_tables_attributes: [:id, :event_user_id, :music_id, :part_id, :recruitment_status, :requirement_status])
  end

  def lyric_params
    params.require(:lyric).permit(:user_id, :title, :artist, :lyric)
  end
end