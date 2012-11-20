class Url < ActiveRecord::Base
  belongs_to :post
  # attr_accessible :original_url, :url
  before_destroy :ensure_not_referenced_by_post

  validates :original_url, :url, presence: true
  validates :original_url, format: {
    with: %r(^https?://),
    message: "is not valid URL"
  }
  validates :url, format: {
    with: %r(^https?://www.youtube.com/watch),
    message: "is not valid URL"
  }

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
