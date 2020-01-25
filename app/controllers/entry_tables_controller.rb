class EntryTablesController < ApplicationController
  def update
  	entry_table = EntryTable.find_by(music_id: params[:music_id],part_id: params[:part_id])
  	entry_table.music_id = params[:music_id]
  	entry_table.part_id = params[:part_id]
  	if params[:name] == "entry"
	  	event_user = EventUser.find_by(user_id: current_user.id)
	  	entry_table.event_user_id = event_user.id
	  	entry_table.recruitment_status = 1
	  	entry_table.save
      music = Music.find(params[:music_id])
        if music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count == 0
            music.establishment_status = "成立"
            music.save
            flash[:success] = "#{music.title}が成立しました！"
        end
      flash[:success] = "#{entry_table.music.title}の#{entry_table.part.part_name}にエントリーしました！"
      redirect_to event_path(entry_table.part.event_id)
  	elsif params[:name] == "cancel"
  		entry_table.event_user_id = nil
  		entry_table.recruitment_status = 0
  		entry_table.save
      music = Music.find(params[:music_id])
         if music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).where(event_user_id: nil).any?
            music.establishment_status = "募集中"
            music.save
            flash[:danger] = "#{music.title} の成立が取り消されました！"
         end
      flash[:danger] = "#{entry_table.music.title} #{entry_table.part.part_name}のエントリーを取り消しました！"
      redirect_to event_path(entry_table.part.event_id)
  	end
  end

  def destroy
  	entry_table = EntryTable.find_by(music_id: params[:music_id],part_id: params[:part_id])
  	entry_table.destroy
  	redirect_to event_path(entry_table.event_id)
  end
end