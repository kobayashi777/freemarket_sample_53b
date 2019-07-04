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

   def get_category_children
      @category_children = Category.find_by(name: "#{params[:parent_name]}").children
   end

   def get_category_grandchildren
      @category_grandchildren = Category.find_by(name: "#{params[:child_name]}").children
   end
end
