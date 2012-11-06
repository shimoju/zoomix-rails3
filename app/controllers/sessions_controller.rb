# encoding: UTF-8
class SessionsController < ApplicationController
  skip_before_filter :authorize, only: :callback

  def callback
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    session[:user_id] = user.id

    redirect_to home_url, notice: "ログインしました"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "ログアウトしました"
  end
end
