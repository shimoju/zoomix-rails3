class Timeline < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  # attr_accessible :title, :body

  validates :user_id, :post_id, presence: true
  validates :post_id, uniqueness: { scope: :user_id }
end
