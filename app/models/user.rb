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
  attachment :image

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
      user = User.create(
       uid:      auth.uid,
       provider: auth.provider,
       email:    User.dummy_email(auth),
       password: Devise.friendly_token[0, 20],
       image: auth.info.image,
       name: auth.info.name,
       nickname: auth.info.nickname,
       )
    end
   user
  end

  private
  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end