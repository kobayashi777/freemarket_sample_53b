module RedirectToTop
  extend ActiveSupport::Concern

  private

  # ログインしている場合、トップページへ戻す
  def redirect_to_top
    redirect_to products_path if user_signed_in?
  end
end