# encoding: UTF-8
class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["BASIC_AUTH_NAME"], password: ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?
  protect_from_forgery
  before_filter :authorize

  helper_method :current_user

  private
  def authorize
    unless current_user
      session[:user_id] = nil
      redirect_to root_url, notice: "ログインしてください"
    end
  end
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
end
