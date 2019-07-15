class ItemsController < ApplicationController
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
end
