class ItemsController < ApplicationController
  before_action :check_user_id, only: [:index, :show]

  def index
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    redirect_to item_path, notice: '出品した商品を削除しました'
  end
  private
  def check_user_id
    product = Product.find_by(id: params[:id])
    redirect_to product_path unless current_user&.id == product.exhibitor.id
  end
end
