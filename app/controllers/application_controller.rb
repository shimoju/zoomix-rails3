# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  private
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:user_id] = nil
      redirect_to root_url, notice: "ログインしてください"
    end
  end
end
