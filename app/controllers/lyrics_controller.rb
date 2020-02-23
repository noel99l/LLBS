class LyricsController < ApplicationController
  before_action :show_header, only: [:lyric, :new_confirm, :edit, :edit_confirm, :select_confirm]

  def show_header
    @event = Event.friendly.find(params[:event_id])
    @event_users = EventUser.where(event_id: @event)
  end

  def lyric
    @music = Music.find(params[:music_id])
    @lyric = Lyric.new
    @lyrics = Lyric.where(title: @music.title, artist: @music.artist)
  end

  def new_confirm
    @music = Music.find(params[:music_id])
    @lyric = Lyric.new(lyric_params)
    render :lyric if @lyric.invalid?
  end

  def create
    music = Music.find(params[:music_id])
    lyric = Lyric.new(lyric_params)
    lyric.save
    music.lyric_id = Lyric.last.id
    music.save
    flash[:success] = "#{music.title}の歌詞分けを新規作成、登録しました！"
    redirect_to event_music_path(music.event.friendly_url, music)
  end

  def edit
  	@music = Music.find(params[:music_id])
    @lyric = Lyric.find(params[:id])
  end

  def edit_confirm
  	@music = Music.find(params[:music_id])
  	@lyric = Lyric.find(params[:id])
    @lyric.attributes = lyric_params
    render :lyric if @lyric.invalid?
  end

  def update
  	music = Music.find(params[:music_id])
  	lyric = Lyric.find(params[:id])
  	lyric.update(lyric_params)
  	flash[:success] = "#{music.title}の歌詞分けを更新しました！"
  	redirect_to event_music_path(music.event.friendly_url, music)
  end

  def select_confirm
    @music = Music.find(params[:music_id])
    @lyric = Lyric.find(params[:music][:lyric_id])
    @music.attributes = music_params
    render :lyric if @music.invalid?
  end

  def select
    music = Music.find(params[:music_id])
    music.update(music_params)
    flash[:success] = "#{music.title}の歌詞分けを登録しました！"
    redirect_to event_music_path(music.event.friendly_url, music)
  end

  private
  def music_params
    params.require(:music).permit(:event_id, :title, :artist, :music_url, :remarks, :user_id, :lyric_id)
  end

  def lyric_params
    params.require(:lyric).permit(:user_id, :title, :artist, :lyric)
  end
end
