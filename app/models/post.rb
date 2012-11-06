class Post < ActiveRecord::Base
  has_many :timeline
  has_many :users, through: :timeline
  has_many :urls, dependent: :destroy
  attr_accessible :name, :posted_at, :postid, :source, :text, :uid

  validates :name, :posted_at, :postid, :source, :text, :uid, presence: true
  validates :postid, uniqueness: { scope: :source }
end
