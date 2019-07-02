class ProductsController < ApplicationController

   def index

   end

   def show

   end

   def new

   end

   def create
   
   end

   def edit

   end

   def destroy

   end

   private
   def poduct_params
      params.require(:product).permit(:name)
   end
end
