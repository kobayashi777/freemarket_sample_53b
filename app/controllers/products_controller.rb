class ProductsController < ApplicationController
   def index
      @products = Product.all
   end

   def show
    # @product = Product.find(params: product_id)
   end

   def new
   end

   def edit

   end

   def destroy

   end

  
end
