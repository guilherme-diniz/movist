class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    puts request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.save!
    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end
