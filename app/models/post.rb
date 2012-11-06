class Post < ActiveRecord::Base
  attr_accessible :name, :posted_at, :postid, :source, :text, :uid
end
