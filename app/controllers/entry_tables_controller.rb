class EntryTablesController < ApplicationController
  before_action :twitter_client #twitterBot用
    def twitter_client
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch("TWITTER_API_KEY")
      config.consumer_secret = ENV.fetch("TWITTER_API_SECRET_KEY")
      config.access_token = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    end
  end

  def update
    event = Event.friendly.find(params[:event_id])
  	entry_table = EntryTable.find_by(music_id: params[:music_id],part_id: params[:part_id])
  	entry_table.music_id = params[:music_id]
  	entry_table.part_id = params[:part_id]
  	if params[:name] == "entry"
	  	event_user = EventUser.where(event_id: event).find_by(user_id: current_user)
	  	entry_table.event_user_id = event_user.id
	  	entry_table.recruitment_status = 1
      music = Music.find(params[:music_id])
      #エントリー前の成立状況を取得
      imm = music.establishment_count

	  	entry_table.save
      calculate_level(10)
      flash[:success] = "#{entry_table.music.title}の#{entry_table.part.part_name}にエントリーしました！"
      #status = "このツイートはテストです\n#{entry_table.music.title}の#{entry_table.part.part_name}にエントリーしました！\nhttp://localhost:3000/admin/events/#{entry_table.part.event.friendly_url}"
      #@twitter.update(status)
      music = Music.find(params[:music_id])
      music.establishment_count =   music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count
      music.save
      if imm != 0 && music.establishment_count == 0
        flash[:warning] = "#{music.title}が成立しました！"
      #status = "#{music.title} が成立しました！\nhttp://localhost:3000/admin/events/#{entry_table.part.event.friendly_url}"
      #@twitter.update(status)
      end
      redirect_back(fallback_location: event_path(entry_table.part.event.friendly_id))
  	elsif params[:name] == "cancel"
  		entry_table.event_user_id = nil
  		entry_table.recruitment_status = 0
      music = Music.find(params[:music_id])
      #エントリー取り消し前の成立状況を取得
      imm = music.establishment_count

  		entry_table.save
      calculate_level(-10)
      flash[:danger] = "#{entry_table.music.title} #{entry_table.part.part_name}のエントリーを取り消しました！"
      #status = "このツイートはテストです\n#{entry_table.music.title}の#{entry_table.part.part_name}のエントリーを取り消しました！\nhttp://localhost:3000/admin/events/#{entry_table.part.event.friendly_url}"
      #@twitter.update(status)
      music.establishment_count = music.entry_tables.where(requirement_status: "必須" ,event_user_id: nil).count
      if imm == 0 && music.establishment_count != 0
        flash[:warning] = "#{music.title}の成立が取り消されました！"
        #status = "このツイートはテストです\n#{music.title} の成立が取り消されました！\nhttp://localhost:3000/admin/events/#{entry_table.part.event.friendly_url}"
        #@twitter.update(status)
      end
      music.save
      redirect_back(fallback_location: event_path(entry_table.part.event.friendly_id))
  	end
  end

  def calculate_level(exp)
    if exp < 0
      current_user.level_up?(exp)
      flash[:info] = "エントリー取り消し #{exp.to_i}pt"
    elsif current_user.level_up?(exp)
      flash[:info] = "楽曲エントリー #{exp.to_i}pt Get! Level UP!"
    else
      flash[:info] = "楽曲エントリー #{exp.to_i}pt Get!"
    end
  end
end