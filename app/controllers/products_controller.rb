class ProductsController < ApplicationController
   # before_action: authenticate_user!
   def index
      @products = Product.all
   end

   def show
    # @product = Product.find(params: product_id)
   end
   
   # TODO:画像投稿機能のS3設定と本番環境での分岐
   # FIXME:他の項目でバリデーションかかっても画像だけ保存される問題
   def new
      @product = Product.new

      @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
         @category_parent_array << parent.name
      end
   end

   def create
      @product = Product.new(product_params)
      @product.photos.attach(params[:photos])
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
      @product = Product.find(params[:id])
      @product_photos = @product.photos
      @selected_grandchild_category = @product.category
      @category_grandchildren_array = [{id: "---", name: "---"}]
      Category.find("#{@selected_grandchild_category.id}").siblings.each do |grandchild|
        grandchildren_hash = {id: "#{grandchild.id}", name: "#{grandchild.name}"}
        @category_grandchildren_array << grandchildren_hash
      end
      @selected_child_category = @selected_grandchild_category.parent
      @category_children_array = [{id: "---", name: "---"}]
      Category.find("#{@selected_child_category.id}").siblings.each do |child|
        children_hash = {id: "#{child.id}", name: "#{child.name}"}
        @category_children_array << children_hash
      end
      @selected_parent_category = @selected_child_category.parent
      @category_parents_array = [{id: "---", name: "---"}]
      Category.find("#{@selected_parent_category.id}").siblings.each do |parent|
        parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
        @category_parents_array << parent_hash
      end
      if @selected_size = @product.products_size
        @size_siblings_array = [{id: "---", size: "---"}]
        ProductsSize.find("#{@selected_size.id}").siblings.each do |sibling|
          sibling_hash = {id: "#{sibling.id}", size: "#{sibling.size}"}
          @size_siblings_array << sibling_hash
        end
      else
        @selected_size = nil
      end
      if @product.delivery_charge == "送料込み（出品者負担）"
        @delivery_method_array = ['---', '未定','らくらくメルカリ便','ゆうメール','レターパック','普通郵便（定型、定型外）',
          'クロネコヤマト','ゆうパック','クリックポスト','ゆうパケット']
      else
        @delivery_method_array = ['---','ゆうメール','クロネコヤマト','ゆうパック']
      end
      @sales_fee = "#{(@product.price.to_i*0.1).round}"
      @sales_profit = "#{(@product.price.to_i*0.9).round}"
    end
  

   def update
      binding.pry
      Product.find(params[:id]).update(product_edit_params)
      redirect_to root_path
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
      params.require(:product).permit(:product_name, :product_introduction, :category_id, :products_size_id, :brand_id, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, photos: []).merge(exhibitor_id: current_user.id, category_id: params[:category_id], products_size_id: params[:products_size_id],)
   end

   def product_edit_params
      params.require(:product).permit(:product_name, :product_introduction, :category_id, :products_size_id, :product_status, :delivery_charge, :delivery_method, :delivery_area, :delivery_days, :price, photos: []).merge(brand_id: Brand.find_by(name: "#{params.require(:product)[:brand]}").id)
   end
end
