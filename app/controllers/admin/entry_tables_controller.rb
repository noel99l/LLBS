class Admin::EntryTablesController < AdminController
  def update
  	entry_table = EntryTable.find_by(music_id: params[:music_id],part_id: params[:part_id])
  	entry_table.music_id = params[:music_id]
  	entry_table.part_id = params[:part_id]
    if params[:name] == "entry"
      entry_table.event_user_id = params[:event_user]
      entry_table.recruitment_status = 1
      music = Music.find(params[:music_id])
      imm = music.establishment_count #エントリー前の成立状況を取得
      entry_table.save
      flash[:success] = "#{entry_table.event_user.user.name}さんが#{entry_table.music.title}の#{entry_table.part.part_name}にエントリーしました！"
      music = Music.find(params[:music_id])
      music.establishment_count = music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count
      music.save
      if imm != 0 && music.establishment_count == 0
        flash[:warning] = "#{music.title}が成立しました！"
      end
      redirect_back(fallback_location: admin_event_path(entry_table.part.event.friendly_url))

  	elsif params[:name] == "cancel"
      flash[:danger] = "#{entry_table.event_user.user.name}さんによる #{entry_table.music.title} の #{entry_table.part.part_name} のエントリーを取り消しました！"
  		entry_table.event_user_id = nil
  		entry_table.recruitment_status = 0
  		entry_table.save
      music = Music.find(params[:music_id])
      imm = music.establishment_count #エントリー取り消し前の成立状況を取得
      music.establishment_count = music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count
      music.save
      if imm == 0 && music.establishment_count != 0
        flash[:warning] = "#{music.title}の成立が取り消されました！"
      end
      redirect_back(fallback_location: admin_event_path(entry_table.part.event.friendly_url))
  	end
  end
end