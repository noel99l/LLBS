class MusicCommentsController < ApplicationController
  def create
  	@music = Music.find(params[:music_id])
    @music_comment = current_user.music_comments.new(music_comment_params)
    @music_comment.music_id = @music.id
    @music_comment.score = Language.get_data(music_comment_params[:comment])
    if @music_comment.save
       exp = (@music_comment.score * 5 + 5).round
       calculate_level(exp)
       flash[:success] = "#{@music.title}にコメントを書き込みました。"
       redirect_to event_music_path(@music.event.friendly_id, @music_comment.music_id)
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
    exp = -(music_comment.score * 5 + 5).round
    calculate_level(exp)
    flash[:danger] = "#{music.title}のコメントを削除しました。"
  	redirect_to event_music_path(music.event.friendly_id, music_comment.music_id)
  end

  def calculate_level(exp)
    if exp < 0
      current_user.level_up?(exp)
      flash[:info] = "コメントの削除 #{exp.to_i}pt"
    elsif current_user.level_up?(exp)
      flash[:info] = "コメント投稿 #{exp.to_i}pt Get! Level UP!"
    else
      flash[:info] = "コメント投稿 #{exp.to_i}pt Get!"
    end
  end

  private
	def music_comment_params
	    params.require(:music_comment).permit(:music_id,:user_id,:comment)
	end
end
