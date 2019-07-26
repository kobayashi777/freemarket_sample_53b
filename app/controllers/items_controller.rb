class ItemsController < ApplicationController
  before_action :check_user_id, only: [:index, :show, :destroy]

  def index
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to mypage_index_path, notice: '出品した商品を削除しました'
  end
  private
  def check_user_id
    product = Product.find_by(id: params[:id])
    redirect_to root_path unless current_user&.id
  end
end
