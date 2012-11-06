class User < ActiveRecord::Base
  attr_accessible :access_token, :access_token_secret, :name, :provider, :salt, :uid
end
