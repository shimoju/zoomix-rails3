class Url < ActiveRecord::Base
  belongs_to :post
  attr_accessible :original_url, :url

  validates :original_url, :url, presence: true
end
