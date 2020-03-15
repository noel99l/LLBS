Admin.find_or_create_by!(email: 'admin@admin') do |admin|
  admin.password = 'password'
end

#レベルテーブル
Level.find_or_create_by!(threshold: 50)
Level.find_or_create_by!(threshold: 100)
Level.find_or_create_by!(threshold: 150)
Level.find_or_create_by!(threshold: 200)
Level.find_or_create_by!(threshold: 250)
# 6レベル以降はthresholdを緩やかに上げる
100.times do |n|
  id = n + 6
  threshold = Level.find(id - 1).threshold + 50 + (id / 10).floor
  Level.find_or_create_by!(threshold: threshold)
end

#テストユーザー作成
User.create!({
	name:"TEST USER",
	provider: 'twitter',
  	email: 'user1@llbs',
    nickname: "TEST_USER",
    introduction: "テストユーザーです。",
    password: 'password',
    password_confirmation: 'password',
    exp: 20,
    level_id: 1
})

49.times { |n|
    User.find_or_create_by(name: Faker::Name.name) do |u|
  	u.provider = 'twitter'
  	u.email = Faker::Internet.email
    u.nickname = "user#{n}"
    u.introduction = "セッション参加は#{n}回目です。よろしくお願いします。"
    u.password = 'password'
    u.password_confirmation = 'password'
    u.exp = 90
    u.level_id = 2
  end

	Lyric.create do |l|
		l.title = "LLBSmusic"
		l.user_id = rand(50) + 1
		l.artist = LLBS
		l.lyric = "<div>TEST lyric</div>"
	end
}

1.upto(4) { |n|
	Event.create do |event|
		event.event_name = Faker::Music.genre + "セッション#{n}"
		event.friendly_url = "LLBS#{n}"
		event.overview = "第#{n}回目の開催となるセッションです。みなさま奮ってご参加ください。"
		event.date = "2020-0#{n}-28"
		event.meeting_time = "2020-0#{n}-31 12:00:00"
		event.start_time = "2020-0#{n}-31 13:00:00"
		event.finish_time = "2020-0#{n}-31 18:00:00"
		event.entry_start_time = "2020-0#{n}-01 13:00:00"
		event.entry_finish_time =  "2020-0#{n}-31 18:00:00"
		event.place = "ノアスタジオ学芸大学店#{n}号店"
		event.place_url = 'https://www.studionoah.jp/shibuya1/'
		event.performance_fee = 2500
		event.visit_fee = 1000
		event.releace_flag = true
		event.timetable_releace = false
	end

	5.times{ |p|
		music = Music.create do |music|
			music.title = Faker::Music::Phish.song
			music.event_id = n
			music.artist = Faker::Music.band
			music.music_url = "https://www.youtube.com/watch?v=" + SecureRandom.base64(11)
			music.establishment_count = 0
			music.remarks = "LLBS#{n}music#{p}の曲です"
			music.user_id = rand(50) + 1
			music.lyric_id = 1
			position = p + 1
		end
	}

	6.upto(10){ |p|
		music = Music.create do |music|
			music.title = Faker::Music::Phish.song
			music.event_id = n
			music.artist = Faker::Music.band
			music.music_url = "https://www.youtube.com/watch?v=" + SecureRandom.base64(11)
			music.establishment_count = 9
			music.remarks = "LLBS#{n}music#{p}の曲です"
			music.user_id = rand(50) + 1
			music.lyric_id = 1
			position = p
		end
	}

	4.times{ |p|
		EventThread.create do |eventthread|
			eventthread.title = Faker::Music.genre + "が好きな人話しましょう！"
			eventthread.event_id = n
			eventthread.user_id = rand(50) + 1
			eventthread.body = "LLBS#{n}掲示板#{p}の書き込みです"
			end
		4.times{ |r|
			EventThreadComment.create do |event_thread_comment|
				event_thread_comment.comment = "テストコメント#{n}#{p}#{r}です。"
				event_thread_comment.event_thread_id = rand(16) + 1
				event_thread_comment.user_id = rand(50) + 1
				event_thread_comment.score = 1
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
	PartTable.create!([
		{ event_id: n,
		  part_name: "Vo",
		  count: 3,
		  observe: 0},
		{ event_id: n,
		  part_name: "Gt",
		  count: 2,
		  observe: 0},
		{ event_id: n,
		  part_name: "Ba",
		  count: 1,
		  observe: 0},
		{ event_id: n,
		  part_name: "Dr",
		  count: 1,
		  observe: 0},
		{ event_id: n,
		  part_name: "Key",
		  count: 1,
		  observe: 0},
		{ event_id: n,
		  part_name: "Perc",
		  count: 1,
		  observe: 0},
		{ event_id: n,
		  part_name: "見学",
		  count: 1,
		  observe: 1}
	])
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
		  part_name: "Key"},
		{ event_id: n,
		  part_name: "Perc"}
	])
}

1.upto(4) { |n|
	1.upto(50) { |p|
		event_user = EventUser.find_or_create_by(user_id: p, event_id: n) do |e|
		e.party_participate = rand(3)
		e.part_table_id = rand(7 * (n - 1) + 1 .. 7 * n)
		end
	}
}

#エントリーテーブル作成
1.upto(5) { |p|
	1.upto(9) { |n|
	    EntryTable.find_or_create_by!(part_id: n, music_id: p) do |e|
		    e.event_user_id = rand(50) + 1
		    e.recruitment_status = 1
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

11.upto(15) { |p|
	10.upto(18) { |n|
	    EntryTable.find_or_create_by!(part_id: n, music_id: p) do |e|
		    e.event_user_id = rand(50) + 1
		    e.recruitment_status = 1
		    e.requirement_status = 0
	    end
	}
}

16.upto(20) { |p|
	10.upto(18) { |n|
	    EntryTable.create!(
	    	event_user_id: nil,
	    	music_id: p,
		    part_id: n,
		    recruitment_status: 0,
		    requirement_status: 0
	    )
	}
}

21.upto(25) { |p|
	19.upto(27) { |n|
	    EntryTable.find_or_create_by!(part_id: n, music_id: p) do |e|
		    e.event_user_id = rand(50) + 1
		    e.recruitment_status = 1
		    e.requirement_status = 0
	    end
	}
}

26.upto(30) { |p|
	19.upto(27) { |n|
	    EntryTable.create!(
	    	event_user_id: nil,
	    	music_id: p,
		    part_id: n,
		    recruitment_status: 0,
		    requirement_status: 0
	    )
	}
}

31.upto(35) { |p|
	28.upto(36) { |n|
	    EntryTable.find_or_create_by!(part_id: n, music_id: p) do |e|
		    e.event_user_id = rand(50) + 1
		    e.recruitment_status = 1
		    e.requirement_status = 0
	    end
	}
}

36.upto(40) { |p|
	28.upto(36) { |n|
	    EntryTable.create!(
	    	event_user_id: nil,
	    	music_id: p,
		    part_id: n,
		    recruitment_status: 0,
		    requirement_status: 0
	    )
	}
}