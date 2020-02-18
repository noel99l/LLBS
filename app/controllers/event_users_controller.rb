class EventUsersController < ApplicationController
  def create
    @event_user = current_user.event_users.build(event_users_params)
    if@event_user.save
      calculate_level(50)
      flash[:success] = "#{@event_user.event.event_name}への参加を受付しました！"
       redirect_to event_path(@event_user.event.friendly_url)
    else
      @event_user.errors
      @event = Event.friendly.find(params[:event_id])
      @parts = Part.where(event_id: @event.id).order(:id)
      @after_party = AfterParty.find_by(event_id: @event.id)
      @event_users = EventUser.where(event_id: @event.id)
      render template: "events/confirm"
    end
  end

  def index
    @event = Event.friendly.find(params[:event_id])
    @event_users = EventUser.where(event_id: @event.id)
    @parts = Part.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
  end

  def update
    event = Event.find(params[:event_id])
    event_user = EventUser.find_by(event_id: event.id, user_id: current_user.id)
    if params[:participate] == "attendance"
      event_user.party_participate = 1
    elsif params[:participate] == "absence"
      event_user.party_participate = 0
    elsif params[:participate] == "under_review"
      event_user.party_participate = 2
    end
    flash[:success] = "#{event_user.event.event_name}の打ち上げ参加登録を#{event_user.party_participate}で受付しました！"
    event_user.save
    redirect_to event_party_path(event.friendly_url)
  end

  def destroy
    event = Event.find(params[:event_id])
    event_user = EventUser.find_by(event_id: event, user_id: current_user)
    entry_tables = EntryTable.where(event_user_id: event_user)
    entry_tables.each do |entry_table|
      entry_table.event_user_id = nil
      calculate_level(-10)
      entry_table.save
    end
    event_user.destroy
    calculate_level(-50)
    flash[:danger] = "#{event_user.event.event_name}への参加を取り消しました！"
    redirect_to root_path
  end

  def calculate_level(exp)
    if exp < 0
      current_user.level_up?(exp)
      flash[:info] = "イベント参加取消 #{exp.to_i}pt"
    elsif current_user.level_up?(exp)
      flash[:info] = "イベント参加 #{exp.to_i}pt Get! Level UP!"
    else
      flash[:info] = "イベント参加 #{exp.to_i}pt Get!"
    end
  end

  private
  def event_users_params
    params.require(:event_user).permit(:event_id, :part_id, :party_participate).merge(user_id: current_user.id)
  end
end
