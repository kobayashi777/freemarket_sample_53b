class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    products_path # ログイン後に遷移するpathを設定
  end
  
  def after_sign_out_path_for(resource)
    products_path # ログアウト後に遷移するpathを設定
  end

  private

  def production?
    Rails.env.production?
  end

# TODO: Basic認証仮置き 環境変数で設定に要変更
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      # username == 'hoge' && password == '1234'
    end
  end

end
