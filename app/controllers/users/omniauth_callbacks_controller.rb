class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end
  
  def callback_for(provider)
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @sns_credential = SnsCredential.from_omniauth(request.env["omniauth.auth"])
    session[:nickname] = request.env["omniauth.auth"].info.name
    session[:email] = request.env["omniauth.auth"].info.email
    session[:password] = Devise.friendly_token[0,20]
    session[:provider] = @sns_credential.provider
    session[:uid] = @sns_credential.uid
  
    if session[:flag] == "signup"
      # session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to registration_signup_index_path
    elsif @sns_credential.persisted?
      sign_in_and_redirect @sns_credential.user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session[:error] = "#{provider.capitalize}での登録情報はありません。他の方法でログインをお試しください。"
      redirect_to new_user_session_path
    end
  
    # if @sns_credential.persisted?
    #   sign_in_and_redirect @sns_credential.user, event: :authentication #this will throw if @user is not activated
    #   set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    # else
    #   session["devise.facebook_data"] = request.env["omniauth.auth"]
    #   redirect_to registration_signup_index_path
    # end
  end

  def failure
    redirect_to root_path
  end
end
