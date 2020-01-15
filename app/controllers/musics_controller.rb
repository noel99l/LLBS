class MusicsController < ApplicationController
  def new
    @music = Music.new
    @entry_table = @music.entry_tables.build
    @event = Event.find(params[:event_id])
    @parts = Part.where(event_id: @event.id)
  end

  def show
    @event = Event.find(params[:event_id])
    @music = Music.find(params[:id])
    @music_comments = MusicComment.where(music_id: @music.id)
    @music_comment = MusicComment.new
    @entry_tables = EntryTable.where(music_id: @music.id)
    event_current_user = EventUser.find_by(event_id: @event.id, user_id: current_user.id)
    @current_user_entry_tables = EntryTable.where(music_id: @music.id, event_user_id: event_current_user.id)
  end

  def create
    music = Music.new(music_params)
    music.save
    redirect_to event_path(music.event_id)
  end

  def edit
    @event = Event.find(params[:event_id])
    @music = Music.find(params[:id])
    @entry_table = @music.entry_tables.all
    @parts = Part.where(event_id: @event.id)
  end

  def update
    music = Music.find(params[:id])
    if music.update(music_params)
      if music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count == 0 #もしもエントリーテーブル必須でユーザーidが入っていないレコードが１つもないならば
            music.establishment_status = "成立"
            music.save
      else music.establishment_status = "募集中"
            music.save
      end
      redirect_to event_music_path(music.event_id, music.id), notice: "楽曲を更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    music = Music.find(params[:id])
    music.destroy
    redirect_to event_path(music.event_id), notice: "楽曲を削除しました！"
  end

  private
  def music_params
    params.require(:music).permit(:event_id, :title, :artist, :music_url, :remarks,
     entry_tables_attributes: [:id, :event_user_id, :music_id, :part_id, :recruitment_status, :requirement_status])
  end
end