class MusicCommentsController < ApplicationController
  def create
  	@music = Music.find(params[:music_id])
    @music_comment = current_user.music_comments.new(music_comment_params)
    @music_comment.music_id = @music.id
    if @music_comment.save
       flash[:success] = "#{@music.title}にコメントを書き込みました。"
       redirect_to event_music_path(@music.event_id, @music_comment.music_id)
    else
      @event = Event.friendly.find(params[:event_id])
      @music_comments = MusicComment.where(music_id: @music.id)
      @entry_tables = EntryTable.where(music_id: @music.id)
      event_current_user = EventUser.find_by(event_id: @event.id, user_id: current_user.id)
        if EntryTable.where(music_id: @music.id, event_user_id: event_current_user.id).presence
        @current_user_entry_tables = EntryTable.where(music_id: @music.id, event_user_id: event_current_user.id)
        end
       render 'musics/show'
    end
  end

  def destroy
  	music = Music.find(params[:music_id])
  	music_comment = MusicComment.find(params[:id])
  	music_comment.destroy
    flash[:danger] = "#{music.title}のコメントを削除しました。"
  	redirect_to event_music_path(music.event_id, music_comment.music_id)
  end

  private
	def music_comment_params
	    params.require(:music_comment).permit(:music_id,:user_id,:comment)
	end
end
