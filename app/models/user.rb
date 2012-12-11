class User < ActiveRecord::Base
  has_many :timeline, dependent: :destroy
  has_many :posts, through: :timeline
  # attr_accessible :access_token, :access_token_secret, :name, :provider, :uid, :username
  attr_encrypted :access_token, key: Settings.crypt.password
  attr_encrypted :access_token_secret, key: Settings.crypt.password

  validates :encrypted_access_token, :encrypted_access_token_secret, :name, :provider, :uid, :username, presence: true
  validates :uid, uniqueness: { scope: :provider }

  devise :omniauthable, :trackable

  def self.from_omniauth(auth)
    user = find_by_provider_and_uid(auth[:provider], auth[:uid])
    unless user
      create do |user|
        user.provider = auth[:provider]
        user.uid = auth[:uid]
        # Twitter: nickname->screen_name, name->name
        user.name = auth[:info][:name]
        user.username = auth[:info][:nickname]
        user.access_token = auth[:credentials][:token]
        user.access_token_secret = auth[:credentials][:secret]
      end
    else
      user.name = auth[:info][:name]
      user.username = auth[:info][:nickname]
      user.access_token = auth[:credentials][:token]
      user.access_token_secret = auth[:credentials][:secret]
      user.save
      user
    end
  end
end
