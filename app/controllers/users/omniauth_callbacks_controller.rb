class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      redirect_to root_url
      set_flash_message(:alert, :failure, kind: 'Twitter', reason: @user.errors.full_messages.join(''))
    end
  end
end
