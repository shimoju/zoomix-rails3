class Post < ActiveRecord::Base
  has_many :timeline
  has_many :urls, dependent: :destroy
  # attr_accessible :name, :posted_at, :postid, :source, :text, :uid

  validates :name, :posted_at, :postid, :source, :text, :uid, :urls, presence: true
  validates :postid, uniqueness: { scope: :source }
  validates_associated :urls

  def self.from_twitter(tweet)
    source = 'twitter'
    unless tweet.retweet?
      postid = tweet.id.to_s
      posted_at = tweet.created_at
      uid = tweet.user.id.to_s
      name = tweet.user.screen_name
      text = tweet.text
      urls = tweet.urls
    else
      postid = tweet.retweeted_status.id.to_s
      posted_at = tweet.retweeted_status.created_at
      uid = tweet.retweeted_status.user.id.to_s
      name = tweet.retweeted_status.user.screen_name
      text = tweet.retweeted_status.text
      urls = tweet.retweeted_status.urls
    end
    where(source: source, postid: postid).first_or_create do |post|
      post.source = source
      post.postid = postid
      post.posted_at = posted_at
      post.uid = uid
      post.name = name
      post.text = text
      urls.each do |url|
        post.urls.new(url: Hugeurl.get(url.expanded_url).to_s, original_url: url.expanded_url)
      end
    end
  end
end
