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

    if session[:flag] == "signup" && @sns_credential.persisted? # 登録画面からのリクエストかつ、snsでの登録がある場合
      session[:error] = "#{provider.capitalize}ですでに登録されています。"
      session[:error_flag] = "yes" # 登録画面からの認証でエラーを取得したことを示すフラグ
      redirect_to signup_index_path
    elsif session[:flag] == "signup" # 登録画面からのリクエストだが、snsでの登録がない場合
      redirect_to registration_signup_index_path
    elsif session[:flag] == "signin" && @sns_credential.persisted? # ログイン画面からのリクエストかつ、snsでの登録がある場合
      sign_in_and_redirect @sns_credential.user, event: :authentication
    else # ログイン画面からのリクエストだが、snsでの登録がない場合
      session[:error] = "#{provider.capitalize}での登録情報はありません。他の方法でログインをお試しください。"
      redirect_to new_user_session_path
    end

  end

  def failure
    redirect_to root_path
  end
end
