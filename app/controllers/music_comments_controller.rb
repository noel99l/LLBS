class MusicCommentsController < ApplicationController
  def create
  	music = Music.find(params[:music_id])
    music_comment = current_user.music_comments.new(music_comment_params)
    music_comment.music_id = music.id
    if music_comment.save
       flash[:success] = "コメントを書き込みました。"
       redirect_to event_music_path(music.event_id, music_comment.music_id)
    else
       @user = current_user
       render 'musics/show'
    end
  end

  def destroy
  	music = Music.find(params[:music_id])
  	music_comment = MusicComment.find(params[:id])
  	music_comment.destroy
  	redirect_to event_music_path(music.event_id, music_comment.music_id)
  end

  private
	def music_comment_params
	    params.require(:music_comment).permit(:music_id,:user_id,:comment)
	end
end
