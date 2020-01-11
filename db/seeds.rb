Admin.find_or_create_by!(email: 'admin@admin') do |admin|
  admin.password = 'password'
end

50.times { |m|
  n = m + 1
  user = User.find_or_create_by!(email: "user#{n}@llbs") do |u|
  	u.provider = 'twitter'
    u.name = "ユーザー#{n}"
    u.nickname = "user#{n}"
    u.image = "http://pbs.twimg.com/profile_images/#{n}"
    u.introduction = "セッション参加は#{n}回目です。よろしくお願いします。"
    u.password = 'password'
    u.password_confirmation = 'password'
  end
}

4.times { |m|
  n = m + 1
	event = Event.find_or_create_by!(event_name: "LLBS#{n}") do |e|
		e.after_party_id = n
		e.friendly_url = "LLBS#{n}"
		e.overview = "第#{n}回目の開催となるLLBSです。みなさま奮ってご参加ください。"
		e.date = "2014-10-0#{n}"
		e.meeting_time = '12:00:00'
		e.start_time = '13:00:00'
		e.finish_time = '18:00:00'
		e.place = "ノアスタジオ学芸大学店#{n}号店"
		e.place_url = 'https://www.studionoah.jp/shibuya1/'
		e.performance_fee = 2500
		e.visit_fee = 1000
	end

	after_party = AfterParty.find_or_create_by!(event_id: n) do |p|
		p.party_place = '三代目鳥メロ 学芸大学西口店'
		p.party_postalcode = '1520004'
		p.party_address = "東京都目黒区鷹番３丁目７−９ リューワビル #{n}F"
		p.party_overview = "第#{n}回LLBSの打ち上げです。楽しみましょう！"
		p.party_fee = 3500
		p.party_url = 'https://www.hotpepper.jp/strJ001153048/'
	end
}