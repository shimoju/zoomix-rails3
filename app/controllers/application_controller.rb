class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["BASIC_AUTH_NAME"], password: ENV["BASIC_AUTH_PASSWORD"] if Rails.env.production?
  protect_from_forgery

  before_filter :set_locale

  private
    def set_locale
      I18n.locale = session[:locale] || I18n.default_locale
    end
end
