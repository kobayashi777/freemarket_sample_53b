class ProductsController < ApplicationController

   def index
     @product = Product.all
   end

   def show
     @product = Product.find_by(id: params[:id])
   end

   def new
      
   end

   def edit

   end

   def destroy

   end

   private
   # paramsから欲しいデータのみ抽出
   def products_params
    params.require(:product).permit(:id, :product_name, :category_id, :brand_id, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, :product_introduction)
   end
end

