class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :dropdown
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  def after_sign_in_path_for(resource)
    products_path # ログイン後に遷移するpathを設定
  end
  
  def after_sign_out_path_for(resource)
    products_path # ログアウト後に遷移するpathを設定
  end

  class Forbidden < ActionController::ActionControllerError
  end
  rescue_from Forbidden, with: :rescue403
  
  def dropdown
    @parents = Category.where(ancestry:nil)
  end
  private

  def production?
    Rails.env.production?
  end

# TODO: Basic認証仮置き 環境変数で設定に要変更
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      username == 'hoge' && password == '1234'
    end
  end

  def rescue404(e)#エラーメッセージ表示404
    @exception = e
    render template: 'mypage/new', status: 404
  end

  def rescue403(e)#エラーメッセージ表示403
    @exception = e
    render template: 'mypage/new', status: 403
  end

  def rescue500(e)#エラーメッセージ表示403
    @exception = e
    render template: 'mypage/new', status: 500
  end

end
