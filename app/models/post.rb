class Post < ActiveRecord::Base
  has_many :timeline, dependent: :destroy
  has_many :contents, dependent: :destroy
  # attr_accessible :name, :posted_at, :postid, :source, :text, :uid, :username

  validates :contents, :name, :posted_at, :postid, :source, :text, :uid, :username, presence: true
  validates :postid, uniqueness: { scope: :source }
  validates_associated :contents

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
        post_content = post.contents.new
        post_content.original_url = url.expanded_url
        begin
          post_content.url = Hugeurl.get(post_content.original_url).to_s
          post_content.contentid = post_content.gen_content_id
        rescue => e
          logger.error "Error <#{p e}>\nURL: #{url.expanded_url}"
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
