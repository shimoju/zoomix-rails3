class User < ActiveRecord::Base
  has_many :timeline
  has_many :posts, through: :timeline
  attr_accessible :access_token, :access_token_secret, :name, :provider, :salt, :uid

  validates :access_token, :access_token_secret, :name, :provider, :salt, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      # Twitter: nickname->screen_name, name->name
      user.name = auth.info.nickname
      user.salt = Crypt.generate_salt
      user.access_token = Crypt.encrypt(auth.credentials.token, user.salt)
      user.access_token_secret = Crypt.encrypt(auth.credentials.secret, user.salt)
    end
  end
end
