class Content < ActiveRecord::Base
  belongs_to :post
  # attr_accessible :contentid, :original_url, :url
  before_destroy :ensure_not_referenced_by_post

  validates :contentid, :original_url, :url, presence: true
  validates :original_url, format: {
    with: %r(^https?://),
    message: "is not valid URL"
  }
  validates :url, format: {
    with: %r(^https?://www.youtube.com/watch),
    message: "is not valid URL"
  }

  def video_id
    Addressable::URI.parse(self.url).query_values['v']
  end

  def to_embed(options={})
    options = {
      ssl: false,
      privacy_enhanced: false,
      query: {autoplay: 1, rel: 0, wmode: 'transparent'}
    }.deep_merge(options)

    url = Addressable::URI.parse(self.url)
    video_id = url.query_values['v']

    scheme = options[:ssl] ? 'https' : 'http'
    host = options[:privacy_enhanced] ? 'www.youtube-nocookie.com' : 'www.youtube.com'
    path = "/embed/#{video_id}"
    query = options[:query].to_query
    return Addressable::URI.new(
      scheme: scheme,
      host: host,
      path: path,
      query: query
    )
  end

  private
    def ensure_not_referenced_by_post
      if post.nil?
        return true
      else
        errors.add(:base, 'Post still exists')
        return false
      end
    end
end
