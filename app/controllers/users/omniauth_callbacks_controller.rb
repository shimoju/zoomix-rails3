class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    sign_in_and_redirect @user
  end
end
