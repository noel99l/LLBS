class Admin::EventUsersController < AdminController
  def index
    @event = Event.friendly.find(params[:event_id])
    @event_users = EventUser.where(event_id: @event.id)
    @parts = Part.where(event_id: @event.id)
    @entry_tables = EntryTable.joins(:part).where(part_id: @parts)
  end

  def update
    event_user = EventUser.find(params[:id])
    event_user.update(event_users_params)
    flash[:success] = "#{event_user.user.name}さんの打ち上げ参加ステータスを更新しました"
    redirect_to admin_event_event_users_path(event_user.event.friendly_url)
  end

  def destroy
    event_user = EventUser.find(params[:id])
    event_user.destroy
    entry_tables = EntryTable.where(event_user_id: event_user.id)
      entry_tables.each do |entry_table|
      entry_table.event_user_id = nil
      entry_table.save
      end
    flash[:danger] = "#{event_user.user.name}さんの参加を取り消しました"
    redirect_to admin_event_event_users_path(event_user.event.friendly_url)
  end
  private
  def event_users_params
    params.require(:event_user).permit(:event_id, :part_id, :party_participate)
  end
end