class User < ActiveRecord::Base
  has_many :timeline, dependent: :destroy
  has_many :posts, through: :timeline
  # attr_accessible :access_token, :access_token_secret, :name, :provider, :uid
  attr_encrypted :access_token, key: Settings.crypt.password
  attr_encrypted :access_token_secret, key: Settings.crypt.password

  validates :encrypted_access_token, :encrypted_access_token_secret, :name, :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }
  validates_associated :timeline

  devise :omniauthable, :trackable

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      # Twitter: nickname->screen_name, name->name
      user.name = auth.info.nickname
      user.access_token = auth.credentials.token
      user.access_token_secret = auth.credentials.secret
    end
  end
end
