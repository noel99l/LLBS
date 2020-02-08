class EventThreadsController < ApplicationController
before_action :show_header, only: [:new, :confirm, :show, :edit]
  def show_header
    @event = Event.friendly.find(params[:event_id])
    @event_users = EventUser.where(event_id: @event)
  end

  def new
  	@event_thread = EventThread.new(params[:id])
  	@event_threads = EventThread.where(event_id: @event)
  end

  def show
    @event_thread = EventThread.find(params[:id])
    @event_threads = EventThread.where(event_id: @event)
    @event_thread_comments = EventThreadComment.where(event_thread_id: @event_thread)
    @event_users = EventUser.where(event_id: @event)
    if EventUser.find_by(event_id: @event, user_id: current_user).presence
      @event_thread_comment = EventThreadComment.new
    end
  end

  def confirm
    @event_thread = EventThread.new(event_thread_params)
    render :new if @event_thread.invalid?
  end

  def create
  	@event = Event.friendly.find(params[:event_id])
    @event_thread = current_user.event_threads.new(event_thread_params)
	  @event_thread.event_id = @event.id
	 if @event_thread.save
      calculate_level(10)
	    flash[:success] = "「#{@event_thread.title}」を作成しました！"
	    redirect_to event_event_thread_path(@event.friendly_id, @event_thread)
	 else
	    render :new
	 end
  end

  def destroy
  	@event_thread = EventThread.find(params[:id])
  	@event_thread.destroy
    calculate_level(-10)
    flash[:danger] = "「#{@event_thread.title}」を削除しました！"
  	redirect_to event_path(@event_thread.event.friendly_id)
  end

  def calculate_level(exp)
    if exp < 0
      current_user.level_up?(exp)
      flash[:info] = "掲示板の削除 #{exp.to_i}pt"
    elsif current_user.level_up?(exp)
      flash[:info] = "掲示板作成 #{exp.to_i}pt Get! Level UP!"
    else
      flash[:info] = "掲示板作成 #{exp.to_i}pt Get!"
    end
  end

  private
  def event_thread_params
  	params.require(:event_thread).permit(:event_id, :user_id, :title, :body)
  end
end
