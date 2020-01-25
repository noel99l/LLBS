class Admin::EntryTablesController < AdminController
  def update
  	entry_table = EntryTable.find_by(music_id: params[:music_id],part_id: params[:part_id])
  	entry_table.music_id = params[:music_id]
  	entry_table.part_id = params[:part_id]
    flash[:danger] = "#{entry_table.event_user.user.name}さんによる #{entry_table.music.title} の #{entry_table.part.part_name} のエントリーを取り消しました！"
  	if params[:name] == "cancel"
  		entry_table.event_user_id = nil
  		entry_table.recruitment_status = 0
  		entry_table.save
      music = Music.find(params[:music_id])
         if music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).where(event_user_id: nil).any?
            music.establishment_status = "募集中"
            music.save
         end
      redirect_to admin_event_path(entry_table.part.event.friendly_url)
  	end
  end
end