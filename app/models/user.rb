class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :event_users
  has_many :music_comments
  has_many :musics
  has_many :event_threads
  has_many :event_thread_comments
  has_many :lyrics
  attachment :image

  def email_required?
    false
  end

  def level_up?(added_exp)
    update(exp: (exp + added_exp))
    if Level.find(level_id).threshold <= exp
      update(level_id: (level_id + 1))
    elsif Level.find(level_id - 1).threshold > exp
      update(level_id: (level_id - 1))
    end
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.new(
       uid:      auth.uid,
       provider: auth.provider,
       password: Devise.friendly_token[0, 20],
       # image: auth.info.image,
       remote_image_url: auth.info.image,
       name: auth.info.name,
       nickname: auth.info.nickname,
       )
    end
   #戻り値
   user
  end
end