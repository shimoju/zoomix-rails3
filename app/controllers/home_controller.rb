class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    user = current_user
    @user_posts = user.posts.order('posted_at DESC').limit(20).includes :contents
  end
end
