class ProductsController < ApplicationController
   # before_action: authenticate_user!
   def index
      @products = Product.all
   end

   def show
    @product = Product.with_attached_photos.find(params[:id])
    # with_attached_photos は Active Storage の n+1 問題を解決してくれるメソッド
    # with_attached_photos は .all と動作が同じなので .find で細かな指定をする  
   end
   
   def new
      @product = Product.new
   end

   def create
      @product = Product.new(product_params)
      @product.save
      
      
      # # 必須項目が全て満たされていた場合
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

   # 以下全て、formatはjsonのみ
   # 親カテゴリーが選択された後に動くアクション
   def get_category_children
      @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
   end

   # 子カテゴリーが選択された後に動くアクション
   def get_category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
   end

   # 孫カテゴリーが選択された後に動くアクション
   def get_size
      selected_grandchild = Category.find("#{params[:grandchild_id]}") #孫カテゴリーを取得
      if related_size_parent = selected_grandchild.products_sizes[0] #孫カテゴリーと紐付くサイズ（親）があれば取得
         @sizes = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
      else
         selected_child = Category.find("#{params[:grandchild_id]}").parent #孫カテゴリーの親を取得
         if related_size_parent = selected_child.products_sizes[0] #孫カテゴリーの親と紐付くサイズ（親）があれば取得
            @sizes = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
         end
      end
   end

   # 配送料の負担が選ばれた後のアクション
   def get_delivery_method
   end

   private
   
   def product_params
      #params.require(:product).permit(:product_name, :product_introduction, :category_id, :product_size_id, :brand_id, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, photos: []).merge(exhibitor_id: current_user.id, category_id: params[:category_id], products_size_id: params[:products_size_id],)
      # createでbinding.pry product_paramsすると、NoMethodError: undefined method `id' for nil:NilClass
      
      # サイズとブランド以外のハッシュを作成
      primitive_data = params.require(:product).permit(:product_name, :product_introduction, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, photos: []).merge(exhibitor_id: current_user.id, category_id: params[:category_id])
      # サイズの入力欄があるものとないものとで条件分岐し、ハッシュにマージ
      if params[:products_size_id] != nil
         size_added_data = primitive_data.merge(products_size_id: "#{params[:products_size_id]}")
      else
         size_added_data = primitive_data.merge(products_size_id: nil)
      end
      # ブランドの入力があるものとないものとで条件分岐し、最終系のハッシュを作成
      if params[:brand] != ""
         size_added_data.merge(brand_id: Brand.find_or_create_by(name: "#{params[:brand]}", category_id: "#{params[:category_id]}").id)
      else
         size_added_data.merge(brand_id: nil)
      end

   end
end
