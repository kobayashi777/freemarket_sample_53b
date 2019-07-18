class MypageController < ApplicationController


  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

  def new
    @categories = Category.all
  end
  
  def exhibit
    @products = Product.all
  end


end
