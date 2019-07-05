class ProductsController < ApplicationController
   # before_action: authenticate_user!
   def index
   end

   def show
   end
   
   # TODO:画像投稿機能のS3設定と本番環境での分岐
   # FIXME:他の項目でバリデーションかかっても画像だけ保存される問題
   def new
      @product = Product.new
   end

   def create
      @product = Product.new(product_params)

      if @product.save!
         flash[:notice] = "出品が完了しました"
      end
      # 必須項目が全て満たされていた場合
      # if @product.save!
      # flash[:notice] = "出品が完了しました"
      # redirect_to :root
      # else
      # 必須項目が不足していた場合
      # flash[:alert] = "未入力項目があります"
      # redirect_back(fallback_location: root_path)
      # end

   end

   def edit

   end

   def destroy

   end

   private
   # def product_params
   #    params.require(:product).permit(:product_name, :product_introduction, :price, photos: [])
   # end
   def product_params
      params.require(:product).permit(:product_name, :product_introduction, :category_id, :product_size_id, :brand_id, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, photos: [])
   end

end
