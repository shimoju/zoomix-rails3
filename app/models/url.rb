class Url < ActiveRecord::Base
  belongs_to :post
  attr_accessible :original_url, :url
end
