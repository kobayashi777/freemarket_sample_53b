class ProductsController < ApplicationController
   # before_action: authenticate_user!
   def index
      @products = Product.all
   end

   def show
    # @product = Product.find(params: product_id)
   end
   
   # TODO:画像投稿機能のS3設定と本番環境での分岐
   # FIXME:他の項目でバリデーションかかっても画像だけ保存される問題 サーバー側で自動でバッチ処理走らせる？
   def new
      @product = Product.new
      @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
         @category_parent_array << parent.name
      end
   end

   def create
      @products = Product.new(product_params)
      @products.save
      
      
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
      # 編集する商品を選択
      @product = Product.find(params[:id])
      # 登録されている商品の孫カテゴリーのレコードを取得
      @selected_grandchild_category = @product.category
      # 孫カテゴリー選択肢用の配列作成
      @category_grandchildren_array = [{id: "---", name: "---"}]
      Category.find("#{@selected_grandchild_category.id}").siblings.each do |grandchild|
        grandchildren_hash = {id: "#{grandchild.id}", name: "#{grandchild.name}"}
        @category_grandchildren_array << grandchildren_hash
      end
      # 選択されている子カテゴリーのレコードを取得
      @selected_child_category = @selected_grandchild_category.parent
      # 子カテゴリー選択肢用の配列作成
      @category_children_array = [{id: "---", name: "---"}]
      Category.find("#{@selected_child_category.id}").siblings.each do |child|
        children_hash = {id: "#{child.id}", name: "#{child.name}"}
        @category_children_array << children_hash
      end
      # 選択されている親カテゴリーのレコードを取得
      @selected_parent_category = @selected_child_category.parent
      # 親カテゴリー選択肢用の配列作成
      @category_parents_array = [{id: "---", name: "---"}]
      Category.find("#{@selected_parent_category.id}").siblings.each do |parent|
        parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
        @category_parents_array << parent_hash
      end
      # サイズが登録されている場合
      if @selected_size = @product.products_size
         # 登録されているサイズに関連する、サイズ選択肢用の配列作成
        @size_siblings_array = [{id: "---", size: "---"}]
        ProductsSize.find("#{@selected_size.id}").siblings.each do |sibling|
          sibling_hash = {id: "#{sibling.id}", size: "#{sibling.size}"}
          @size_siblings_array << sibling_hash
        end
      else # サイズが登録されていない場合
        @selected_size = nil
      end
      # delivery_chargeに登録されている値を判断し、配送方法の選択肢用の配列を作成
      if @product.delivery_charge == "送料込み（出品者負担）"
        @delivery_method_array = ['---', '未定','らくらくメルカリ便','ゆうメール','レターパック','普通郵便（定型、定型外）',
          'クロネコヤマト','ゆうパック','クリックポスト','ゆうパケット']
      else
        @delivery_method_array = ['---','ゆうメール','クロネコヤマト','ゆうパック']
      end
      # 販売価格の表示
      # 販売手数料の初期値
      @sales_fee = "#{(@product.price.to_i*0.1).round}"
      # 販売利益の初期値
      @sales_profit = "#{(@product.price.to_i*0.9).round}"
    end
  

   def update
      product = Product.find(params[:id])
      if product.update(product_params) # updateが成功した場合
         # 編集ページで削除ボタンを押された写真のデータを削除する
         params[:delete_photos].split(",").each do |id|
            product.photos.find(id).purge
         end
         redirect_to root_path
      else
         redirect_back(fallback_location: edit_product_path)
      end
   end

   def destroy

   end

   # 以下3つ、formatはjsonのみ
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
