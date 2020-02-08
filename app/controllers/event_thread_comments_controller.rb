class EventThreadCommentsController < ApplicationController
	def create
	  @event_thread = EventThread.find(params[:event_thread_id])
    @event_thread_comment = current_user.event_thread_comments.new(event_thread_comment_params)
    @event_thread_comment.event_thread_id = @event_thread.id
    @event_thread_comment.score = Language.get_data(event_thread_comment_params[:comment])
    if @event_thread_comment.save!
       exp = (@event_thread_comment.score * 5 + 5).round
       calculate_level(exp)
       flash[:success] = "#{@event_thread.title}にコメントを書き込みました。"
       redirect_to event_event_thread_path(@event_thread.event.friendly_id, @event_thread)
    else
      @event = Event.friendly.find(params[:event_id])
      @event_thread_comments = EventThreadComment.where(event_thread_id: @event_thread)
      event_current_user = EventUser.find_by(event_id: @event.id, user_id: current_user.id)
       render 'event_threads/show'
    end
  end

  def destroy
  	event_thread = EventThread.find(params[:event_thread_id])
  	event_thread_comment = EventThreadComment.find(params[:id])
  	event_thread_comment.destroy
    exp = -(event_thread_comment.score * 5 + 5).round
    calculate_level(exp)
    flash[:danger] = "#{event_thread.title}のコメントを削除しました。"
  	redirect_to event_event_thread_path(event_thread.event.friendly_id, event_thread)
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
	def event_thread_comment_params
	    params.require(:event_thread_comment).permit(:event_thread_id,:user_id,:comment)
	end
end
