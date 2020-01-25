Admin.find_or_create_by!(email: 'admin@admin') do |admin|
  admin.password = 'password'
end

50.times { |m|
  n = m + 1
  user = User.find_or_create_by!(email: "user#{n}@llbs") do |u|
  	u.provider = 'twitter'
    u.name = "ユーザー#{n}"
    u.nickname = "user#{n}"
    u.introduction = "セッション参加は#{n}回目です。よろしくお願いします。"
    u.password = 'password'
    u.password_confirmation = 'password'
  end
}

4.times { |m|
  n = m + 1
	event = Event.find_or_create_by!(event_name: "LLBS#{n}") do |e|
		e.friendly_url = "LLBS#{n}"
		e.overview = "第#{n}回目の開催となるLLBSです。みなさま奮ってご参加ください。<br>
					　詳細はHPで！"
		e.date = "2014-10-0#{n}"
		e.meeting_time = '12:00:00'
		e.start_time = '13:00:00'
		e.finish_time = '18:00:00'
		e.place = "ノアスタジオ学芸大学店#{n}号店"
		e.place_url = 'https://www.studionoah.jp/shibuya1/'
		e.performance_fee = 2500
		e.visit_fee = 1000
	end

	10.times{ |p|
		o = p + 1
			music = Music.find_or_create_by!(title: "LLBS#{n}music#{o}") do |music|
				music.event_id = n
				music.artist = "artist"
				music.music_url = "https://LLBS#{n}music#{o}"
				music.establishment_status = o % 2
				music.remarks = "LLBS#{n}music#{o}の曲です"
				music.user_id = o % 10 + 1
			end
			4.times{ |r|
				q = r + 1
					music_comment = MusicComment.find_or_create_by!(comment: "LLBS#{n}music#{o}comment#{q}のコメントです。") do |music_comment|
						music_comment.music_id = o
						music_comment.user_id = q
					end
			}
	}

	after_party = AfterParty.find_or_create_by!(event_id: n) do |p|
		p.party_place = '三代目鳥メロ 学芸大学西口店'
		p.party_postalcode = '1520004'
		p.party_address = "東京都目黒区鷹番３丁目７−９ リューワビル #{n}F"
		p.party_overview = "<div><strong>《時間》</strong></div><div><strong>20:30～22:30 (セッションの終了時間によっては後ろ倒しになる可能性あり)</strong></div><div><br></div><div><strong>《料理・料金》</strong></div><div>参加費のほうは飲み放題付き、コース料理でおひとり様3500円の予定となります！</div><div><br></div><div><strong>《注意事項》</strong></div><div>・未成年、18歳未満の方は飲酒や喫煙、条例違反をしないこと。</div><div>・途中参加、途中離脱も可能ですが、料金は変わりません。</div><div>・飲食物の持ち込みは不可です。</div><div>・歩きたばこ等周りのけがにつながる行為は危険なので控えましょう</div><div>・別に荷物置き場を確保してありますが鍵などはかけられませんので、貴重品は自己管理をお願いいたします</div><div>・開催一週間前以降のキャンセルはキャンセル料などかかる場合がありますので予めご了承ください。</div><div>・解散後、店の周辺にたまる行為は周りのお客様、通行人の迷惑になりますので速やかに解散するようお願いします。</div><div><br></div><div>なにか質問等ありましたらのえる(@noel99l)までどうぞ！</div>"
		p.party_fee = 3500
		p.party_url = 'https://www.hotpepper.jp/strJ001153048/'
	end
}

1.upto(4) { |n|
	Part.create!([
		{ event_id: n,
		  part_name: "Vo1"},
		{ event_id: n,
		  part_name: "Vo2"},
		{ event_id: n,
		  part_name: "Vo3"},
		{ event_id: n,
		  part_name: "Gt1"},
		{ event_id: n,
		  part_name: "Gt2"},
		{ event_id: n,
		  part_name: "Ba"},
		{ event_id: n,
		  part_name: "Dr"},
		{ event_id: n,
		  part_name: "Key1"},
		{ event_id: n,
		  part_name: "Perc"}
	])
}

50.times { |m|
  n = m + 1
  event_user = EventUser.find_or_create_by!(user_id: n) do |e|
	e.event_id = 1
	e.part_id = n % 10 + 1
	e.party_participate = n % 3
  end
}

1.upto(5) { |p|
	1.upto(9) { |n|
	    entry_table = EntryTable.find_or_create_by!(event_user_id: n, music_id: p) do |e|
		    e.part_id = n
		    e.recruitment_status = 0
		    e.requirement_status = 0
	    end
	}
}

6.upto(10) { |p|
	1.upto(9) { |n|
	    EntryTable.create!(
	    	event_user_id: nil,
	    	music_id: p,
		    part_id: n,
		    recruitment_status: 0,
		    requirement_status: 0
	    )
	}
}