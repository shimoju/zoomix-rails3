class Post < ActiveRecord::Base
  has_many :timeline, dependent: :destroy
  has_many :urls, dependent: :delete_all
  # attr_accessible :name, :posted_at, :postid, :source, :text, :uid, :username

  validates :name, :posted_at, :postid, :source, :text, :uid, :urls, :username, presence: true
  validates :postid, uniqueness: { scope: :source }
  validates_associated :urls

  scope :latest, order('posted_at DESC').limit(1)
  scope :oldest, order('posted_at').limit(1)

  def self.from_twitter(tweet)
    source = 'twitter'
    if tweet.retweet?
      postid = tweet.retweeted_status.id.to_s
      posted_at = tweet.retweeted_status.created_at
      uid = tweet.retweeted_status.user.id.to_s
      username = tweet.retweeted_status.user.screen_name
      name = tweet.retweeted_status.user.name
      text = tweet.retweeted_status.text
      urls = tweet.retweeted_status.urls
    else
      postid = tweet.id.to_s
      posted_at = tweet.created_at
      uid = tweet.user.id.to_s
      username = tweet.user.screen_name
      name = tweet.user.name
      text = tweet.text
      urls = tweet.urls
    end
    where(source: source, postid: postid).first_or_create do |post|
      post.source = source
      post.postid = postid
      post.posted_at = posted_at
      post.uid = uid
      post.username = username
      post.name = name
      post.text = text
      urls.each do |url|
        post_url = post.urls.new
        post_url.original_url = url.expanded_url
        begin
          post_url.url = Hugeurl.get(url.expanded_url).to_s
        rescue => e
          logger.error "Error Hugeurl <#{p e}>\nURL: #{url.expanded_url}"
          post_url.url = url.expanded_url
        end
      end
    end
  end

  def self.valid_tweet?(tweet)
    return false if tweet.retweet?
    return false if tweet.urls.empty?
    return true
  end
end
