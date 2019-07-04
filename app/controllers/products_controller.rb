class ProductsController < ApplicationController

   def index
   end

   def show
   end
   
   # TODO:画像投稿機能のS3設定と本番環境での分岐
   def new
      @product = Product.new
   end

   def create
      @product = Product.create(product_params)
      redirect_to :root
   end

   def edit

   end

   def destroy

   end

   private
   def product_params
      params.require(:product).permit(:product_name, :product_introduction, photos: [])
   end
   # def product_params
   #    params.require(:product).permit(:product_name, :product_introduction, :category_id, :product_size_id, :brand_id, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, photos: [])
   # end

end
