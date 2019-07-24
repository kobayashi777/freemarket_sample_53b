class MypageController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

  def new
    @categories = Category.all
    @products = Product.with_attached_photos
  end
  
  def exhibit
    @products = Product.all
  end

end
