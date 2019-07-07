class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end
  
  def callback_for(provider)
    # providerからデータを取得
    @sns_credential = SnsCredential.from_omniauth(request.env["omniauth.auth"])
    session[:nickname] = request.env["omniauth.auth"].info.name
    session[:email] = request.env["omniauth.auth"].info.email
    session[:password] = Devise.friendly_token[0,20] # deviseで任意のパスワードを生成
    session[:provider] = @sns_credential.provider
    session[:uid] = @sns_credential.uid

    if session[:flag] == "signup" # flagが"signup"の場合は、新規登録画面へ移行する
      redirect_to registration_signup_index_path
    elsif @sns_credential.persisted? # flagが"signup"ではなく、すでにsns認証で登録してある場合は、signinを行う
      sign_in_and_redirect @sns_credential.user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else # signinに失敗した時のエラーを作成する
      session[:error] = "#{provider.capitalize}での登録情報はありません。他の方法でログインをお試しください。"
      redirect_to new_user_session_path
    end
  end

  def failure
    redirect_to root_path
  end
end
