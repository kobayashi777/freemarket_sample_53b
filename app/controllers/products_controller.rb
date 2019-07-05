class ProductsController < ApplicationController

   def index

   end

   def show

   end

   def new
      @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
         @category_parent_array << parent.name
      end
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
end
