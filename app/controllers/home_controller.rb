class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    user = current_user
    @user_posts = user.posts.order('created_at DESC').limit(20).includes :urls
  end
end
