class EventUsersController < ApplicationController
  def create
    event_user = current_user.event_users.build(event_users_params)
    event_user.save
    redirect_to event_path(event_user.event_id)
  end

  def index
    @event = Event.find(params[:event_id])
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
    event_user.save
    redirect_to event_party_path(event)
  end

  def destroy
    event = Event.find(params[:event_id])
    event_user = EventUser.find_by(event_id: event.id, user_id: current_user.id)
    event_user.destroy
    entry_tables = EntryTable.where(event_user_id: event_user.id)
      entry_tables.each do |entry_table|
      entry_table.event_user_id = nil
      entry_table.save
      end
    redirect_to root_path
  end

  private
  def event_users_params
    params.require(:event_user).permit(:event_id, :part_id, :party_participate).merge(user_id: current_user.id)
  end
end
